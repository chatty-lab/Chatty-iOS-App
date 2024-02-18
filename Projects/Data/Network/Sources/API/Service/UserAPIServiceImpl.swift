//
//  UserAPIServiceImpl.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 1/16/24.
//

import Foundation
import DataNetworkInterface
import DataStorageInterface

import Moya
import RxSwift

public final class UserAPIServiceImpl: UserAPIService {
  public typealias Router = UserAPIRouter
  public var provider: MoyaProvider<UserAPIRouter>  
  
  private let authAPIService: any AuthAPIService
  
  public init(authAPIService: any AuthAPIService, keychainService: KeychainServiceProtocol) {
    self.authAPIService = authAPIService
    self.provider = .init(plugins: [
      MoyaPlugin(keychainService: keychainService)
    ])
  }
}

extension UserAPIServiceImpl {
  public func refreshToken() -> Single<Void> {
    return authAPIService.refreshToken()
  }
}
 
