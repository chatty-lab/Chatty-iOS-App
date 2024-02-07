//
//  UserAPIServiceImpl.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 1/16/24.
//

import Foundation
import Moya
import DataNetworkInterface

public final class UserAPIServiceImpl: UserAPIService {
  public typealias Router = UserAPIRouter
  public var provider: MoyaProvider<UserAPIRouter> = .init(plugins: [
    MoyaLoggingPlugin(),
    AccessTokenPlugin { target in
      let accesstoken = "accesstoken"
      return accesstoken
    }
  ])
  public init() { }
}
