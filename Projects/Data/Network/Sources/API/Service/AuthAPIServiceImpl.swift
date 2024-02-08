//
//  AuthAPIServiceImpl.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 1/15/24.
//

import Foundation
import Moya
import DataNetworkInterface

public final class AuthAPIServiceImpl: AuthAPIService {
  public typealias Router = AuthAPIRouter
  public let provider: Moya.MoyaProvider<AuthAPIRouter> = .init(plugins: [
    MoyaLoggingPlugin(),
    AccessTokenPlugin { target in
      let accesstoken = "accesstoken"
      return accesstoken
    }
  ])
  
  public init() { }
}
