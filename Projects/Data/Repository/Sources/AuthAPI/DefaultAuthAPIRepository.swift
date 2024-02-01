//
//  DefaultAuthAPIRepository.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/27/24.
//

import Foundation
import DataNetworkInterface
import DataRepositoryInterface
import DomainCommonInterface
import RxSwift
import Moya


public final class DefaultAuthAPIRepository<RouterType: TargetType>: AuthAPIRepository {
  
  private let authAPIService: any AuthAPIService
  
  public init(authAPIService: any AuthAPIService) {
    self.authAPIService = authAPIService
  }
  
  public func requestTokenRefresh(refreshToken: String) -> Single<Token> {
    let request = RefreshRequestDTO(refreshToken: refreshToken)
    return authAPIService.request(endPoint: .refresh(request), responseDTO: RefreshResponseDTO.self)
      .map { $0.toDomain() }
  }
}
