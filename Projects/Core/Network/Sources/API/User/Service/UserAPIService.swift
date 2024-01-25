//
//  UserAPIService.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import Moya

public final class UserAPIService: APIServiceProtocol {  
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
