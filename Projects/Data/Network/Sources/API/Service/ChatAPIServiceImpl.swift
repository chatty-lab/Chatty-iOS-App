//
//  ChatAPIServiceImpl.swift
//  DataNetwor
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation
import Moya
import DataNetworkInterface
import RxSwift
import DataStorageInterface

public final class ChatAPIServiceImpl: ChatAPIService {
  public typealias Router = ChatAPIRouter
  public var provider: MoyaProvider<ChatAPIRouter>
  
  private let authAPIService: any AuthAPIService
  
  public init(authAPIService: any AuthAPIService, keychainService: KeychainServiceProtocol) {
    self.authAPIService = authAPIService
    self.provider = .init(plugins: [
      MoyaPlugin(keychainService: keychainService)
    ])
  }
}

extension ChatAPIServiceImpl {
  public func refreshToken() -> Single<Void> {
    return authAPIService.refreshToken()
  }
}
