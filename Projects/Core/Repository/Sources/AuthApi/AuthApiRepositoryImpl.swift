//
//  AuthApiRepository.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/27/24.
//

import Foundation
import CoreNetwork
import CoreRepositoryInterface
import DomainCommonInterface
import RxSwift
import Moya


public final class DefaultAuthApiRepository<RouterType: TargetType>: AuthApiRepositoryProtocol {
  
  private let authAPIService: AuthAPIService
  
  public init(authAPIService: AuthAPIService) {
    self.authAPIService = authAPIService
  }
  
  public func requestTokenRefresh(refreshToken: String) -> Single<Token> {
    let request = RefreshRequestDTO(refreshToken: refreshToken)
    return authAPIService.request(endPoint: .refresh(request), responseDTO: RefreshResponseDTO.self)
      .map { $0.toDomain() }
  }
}
