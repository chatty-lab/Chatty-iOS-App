//
//  KeychainRouter.swift
//  CoreStorage
//
//  Created by 윤지호 on 1/17/24.
//

import Foundation
import DomainCommonInterface

public enum KeychainRouter {
  case accessToken(_ token: String = "")
  case refreshToken(_ token: String = "")
  case deviceToken(_ token: String = "")
  case deviceId(_ id: String = "")
  
  public static func toRouterCase(type: KeychainCase) -> KeychainRouter {
    switch type {
    case .accessToken(let token):
      return .accessToken(token)
    case .refreshToken(let token):
      return .refreshToken(token)
    case .deviceToken(let token):
      return .deviceToken(token)
    case .deviceId(let id):
      return .deviceId(id)
    }
  }
}

public extension KeychainRouter {
  var typeKey: String {
    let appName = "Chatty"
    switch self {
    case .accessToken:
      return appName + "AccessToken"
    case .refreshToken:
      return appName + "RefreshToken"
    case .deviceToken:
      return appName + "DeviceToken"
    case .deviceId:
      return appName + "DeviceId"
    }
  }
  
  var encodedtoken: Data? {
    var string: String = ""
    switch self {
    case .accessToken(let token):
      string = token
    case .refreshToken(let token):
      string = token
    case .deviceToken(let token):
      string = token
    case .deviceId(let id):
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
