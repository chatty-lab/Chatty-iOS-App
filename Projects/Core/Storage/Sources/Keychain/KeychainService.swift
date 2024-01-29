//
//  KeychainService.swift
//  CoreStorage
//
//  Created by 윤지호 on 1/17/24.
//

import Foundation
import RxSwift

public final class KeychainService {
  public static let shared = KeychainService()
  private init() { }

  /// isForce 강제로 중복된 keychain 내의 값을 업데이트 할것인지에 대한 Bool값 입니다.
  public func creat(type: KeychainRouter, isForce: Bool) -> Single<Bool> {
    let status = SecItemAdd(type.query as CFDictionary, nil)
    
    if status == errSecDuplicateItem {
      print("create - Duplicate")
      if isForce {
        return update(type: type)
      }
    } 
    
    if status == errSecSuccess {
      print("create -add success status = \(status)")
      return .just(true)
    } else {
      print("create -add false status = \(status)")
      return .just(false)
    }
  }
  
  public func read(type: KeychainRouter) -> Single<String> {
    var item: AnyObject?
    let status = SecItemCopyMatching(type.readQuery as CFDictionary, &item)
    
    guard status != errSecItemNotFound else {
      print("Keychain read - item not found")
      return .error(NSError(domain: "No Data in Keychain", code: -1))
    }
    
    guard status == errSecSuccess else {
      print("Keychain read - read error")
      return .error(NSError(domain: "No Data in Keychain", code: -1))
    }

    guard let tokenData = item as? Data,
          let token = String(data: tokenData, encoding: .utf8) else {
      print("Keychain read - data error")
      return .error(NSError(domain: "No Data in Keychain", code: -1))
    }
    
    return .just(token)
  }
  
  private func update(type: KeychainRouter) -> Single<Bool> {
    let status = SecItemUpdate(type.query as CFDictionary, type.updateQuery as CFDictionary)
    
    if status == errSecSuccess {
      print("update - success staus = \(status)")
      return .just(true)
    } else {
      print("update - false staus = \(status)")
      return .just(false)
    }
  }

  public func delete(type: KeychainRouter) -> Single<Bool> {
    let status = SecItemDelete(type.deleteQuery as CFDictionary)
    
    if status == errSecSuccess {
      print("delete - success status = \(status)")
      return .just(true)
    } else if status == errSecItemNotFound {
      print("delete - ItemNotFound  status = \(status)")
      return .just(false)
    } else {
      print("delete - false  status = \(status)")
      return .just(false)
    }
  }
}
