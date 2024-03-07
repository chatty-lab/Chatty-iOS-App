//
//  InterestAPIRouter.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 3/7/24.
//

import Foundation
import Moya

public enum InterestAPIRouter: RouterProtocol, AccessTokenAuthorizable {
  case interests
}

public extension InterestAPIRouter {
  var baseURL: URL {
    return URL(string: Environment.baseURL + basePath)!
  }
  
  var basePath: String {
    return "/v1"
  }
  
  var path: String {
    switch self {
    case .interests:
      return "/interests"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .interests:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .interests:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .interests:
      return .none
    }
  }
  
  var authorizationType: Moya.AuthorizationType? {
    switch self {
    case .interests:
      return .bearer
    }
  }
}
