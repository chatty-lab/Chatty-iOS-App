//
//  AuthAPIService.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/15/24.
//

import Foundation
import Moya

public final class AuthAPIService: APIServiceProtocol {
  public typealias Router = AuthAPIRouter
  public let provider: Moya.MoyaProvider<AuthAPIRouter> = .init()
  
  public init() { }
}
