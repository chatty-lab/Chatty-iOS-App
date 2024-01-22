//
//  AuthAPIRouter.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/14/24.
//

import Foundation
import Moya

struct AuthMobileRequest {
  let mobileNumber: String
  let deviceID: String
}

enum AuthAPIRouter: TargetType {
  case mobile(AuthMobileRequest)
}

extension AuthAPIRouter {
  var baseURL: URL {
    URL(string: "https://dev.api.chattylab.org/auth")!
  }
  
  var path: String {
    switch self {
    case .mobile:
      return "/mobile"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .mobile:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .mobile(let request):
      let parameters = [
        "mobileNumber": request.mobileNumber,
        "deviceId": request.deviceID
      ]
      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .mobile(let request):
      return .none
    }
  }
}
