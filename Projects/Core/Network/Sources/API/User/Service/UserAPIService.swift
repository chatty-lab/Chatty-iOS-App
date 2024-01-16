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
  public let provider: MoyaProvider<UserAPIRouter> = .init()
  
  public init() { }
}
