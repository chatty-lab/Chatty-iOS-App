//
//  AuthAPIRouter.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/15/24.
//

import Foundation
import Moya

public enum AuthAPIRouter: Router {
  case mobile(MobileRequestDTO)
  case refresh(RefreshRequestDTO)
  case token(TokenRequestDTO)
}

public extension AuthAPIRouter {
  var baseURL: URL {
    return URL(string: Environment.baseURL + basePath)!
  }
  
  var basePath: String {
    return "/auth"
  }
  
  var path: String {
    switch self {
    case .mobile:
      return "/mobile"
    case .refresh:
      return "/refresh"
    case .token:
      return "/token"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .mobile, .refresh, .token:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .mobile(let mobileRequestDTO):
      return .requestJSONEncodable(mobileRequestDTO)
    case .refresh(let refreshRequestDTO):
      return .requestJSONEncodable(refreshRequestDTO)
    case .token(let tokenRequestDTO):
      return .requestJSONEncodable(tokenRequestDTO)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .mobile, .refresh, .token:
      return ["Content-Type": "application/json"]
    }
  }
}


