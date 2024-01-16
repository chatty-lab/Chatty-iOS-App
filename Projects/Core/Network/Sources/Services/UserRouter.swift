//
//  UserRouter.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation
import Moya
import UIKit

public enum UserRouter: TargetType, AccessTokenAuthorizable {
  case nickname(nickname: String)
  case mbti(mbti: String)
  case image(imageData: Data)
  case gender(gender: String)
  case deviceToken(deviceToken: String)
  case birth(birth: String)
  case login(request: UserSignRequestDTO)
  case join(request: UserSignRequestDTO)
}

public extension UserRouter  {
  var baseURL: URL {
    let base = "https://dev.api.chattylab.org"
    
    return URL(string: base + basePath)!
  }
  
  var basePath: String {
    return "/users"
  }
  
  var path: String {
    switch self {
    case .nickname:
      return "/nickname"
    case .mbti:
      return "/mbti"
    case .image:
      return "/image"
    case .gender:
      return "/gender"
    case .deviceToken:
      return "/deviceToken"
    case .birth:
      return "/birth"
    case .login:
      return "/login"
    case .join:
      return "/join"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .nickname, .mbti, .image, .gender, .deviceToken, .birth:
      return .put
    case .login, .join:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .nickname(let nickname):
      let param = ["nickname": nickname]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .mbti(let mbti):
      let param = ["mbti": mbti]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .image(let image):
      let imagemutipartFormData = MultipartFormData(provider: .data(image), name: "image", fileName: "user_avatar.jpeg", mimeType: "image/jpeg")
      return .uploadMultipart([imagemutipartFormData])
    case .gender(let gender):
      let param = ["gender": gender]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .deviceToken(let deviceToken):
      let param = ["deviceToken": deviceToken]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .birth(let birth):
      let param = ["birth": birth]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .login(let request):
      return .requestJSONEncodable(request)
    case .join(let request):
      return .requestJSONEncodable(request)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .nickname, .mbti, .gender, .deviceToken, .birth:
      return RequestHeader.getHeader([.json])
    case .image:
      return RequestHeader.getHeader([.binary])
    case .login, .join:
      return RequestHeader.getHeader([.json])
    }
  }
  
  var authorizationType: Moya.AuthorizationType? {
    switch self {
    case .nickname, .mbti, .image, .gender, .deviceToken, .birth:
      return .bearer
    default:
      return .none
    }
  }
}
