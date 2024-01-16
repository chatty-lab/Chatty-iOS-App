//
//  UserAPIRouter.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import Moya

public enum UserAPIRouter: Router {
  case login(UserAuthRequestDTO)
  case join(UserAuthRequestDTO)
}

public extension UserAPIRouter {
  var baseURL: URL {
    return URL(string: Environment.baseURL + basePath)!
  }
  
  var basePath: String {
    return "/users"
  }
  
  var path: String {
    switch self {
    case .login:
      return "/login"
    case .join:
      return "/join"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .join, .login:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .login(let userAuthRequestDTO):
      return .requestJSONEncodable(userAuthRequestDTO)
    case .join(let userAuthRequestDTO):
      return .requestJSONEncodable(userAuthRequestDTO)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .login, .join:
      return ["Content-Type": "application/json"]
    }
  }
}
