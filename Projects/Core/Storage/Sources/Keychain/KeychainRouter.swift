//
//  KeychainRouter.swift
//  CoreStorage
//
//  Created by 윤지호 on 1/17/24.
//

import Foundation

public enum KeychainRouter {
  case accessToken(_ token: String = "")
  case refreshToken(_ token: String = "")
  case diviceToken(_ token: String = "")
  case diviceId(_ id: String)
}

public extension KeychainRouter {
  var typeKey: String {
    let appName = "Chatty"
    switch self {
    case .accessToken:
      return appName + "AccessToken"
    case .refreshToken:
      return appName + "RefreshToken"
    case .diviceToken:
      return appName + "DiviceToken"
    case .diviceId:
      return appName + "DiviceId"
    }
  }
  
  var encodedtoken: Data? {
    var string: String = ""
    switch self {
    case .accessToken(let token):
      string = token
    case .refreshToken(let token):
      string = token
    case .diviceToken(let token):
      string = token
    case .diviceId(let id):
      string = id
    }
    let data = string.data(using: .utf8, allowLossyConversion: false)
    return data ?? nil
  }
  
  var query: [String: Any] {
    return [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: typeKey,
      kSecAttrAccount as String: Bundle.main.bundleIdentifier as Any,
      kSecValueData as String: encodedtoken!
    ]
  }
  
  var readQuery: [String: Any] {
    return [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: typeKey,
      kSecAttrAccount as String: Bundle.main.bundleIdentifier as Any,
      kSecMatchLimit as String: kSecMatchLimitOne,
      kSecReturnData as String: kCFBooleanTrue as Any
    ]
  }
  
  var updateQuery: [String: Any] {
    return [
      kSecValueData as String: encodedtoken!
    ]
  }
  
  var deleteQuery: [String: Any] {
    return [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: typeKey,
      kSecAttrAccount as String: Bundle.main.bundleIdentifier as Any
    ]
  }
}
