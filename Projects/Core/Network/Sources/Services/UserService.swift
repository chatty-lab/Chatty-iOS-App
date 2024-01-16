//
//  UserService.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation
import RxSwift
import Moya
import UIKit

public class UserService: ApiServiceProtocol {
  public typealias Router = UserRouter
  public var provider: MoyaProvider<UserRouter> = .init(plugins: [
    MoyaLoggingPlugin(),
    AccessTokenPlugin { target in
      let accesstoken = "accesstoken"
      return accesstoken
    }
  ])
  public init() { }
}

