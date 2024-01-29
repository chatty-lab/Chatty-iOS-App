//
//  AuthApiRepository.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/27/24.
//

import Foundation
import CoreNetwork
import RxSwift
import Moya

public protocol AuthApiRepositoryProtocol {
  func requestTokenRefresh(request: RefreshRequestDTO) -> Single<TokenResponseDTO>
}

public final class DefaultAuthApiRepository<RouterType: TargetType>: AuthApiRepositoryProtocol {
  private let manager: AuthAPIService
  
  public init(manager: AuthAPIService) {
    self.manager = manager
  }
  
  public func requestTokenRefresh(request: RefreshRequestDTO) -> Single<TokenResponseDTO> {
    manager.request(endPoint: .refresh(request), responseDTO: TokenResponseDTO.self)
  }
  
  
}
