//
//  KeychainService.swift
//  CoreStorage
//
//  Created by 윤지호 on 1/17/24.
//

import Foundation

public final class KeychainService {
  public init() { }

  /// isForce 강제로 중복된 keychain 내의 값을 업데이트 할것인지에 대한 Bool값 입니다.
  public func creat(type: KeychainRouter, isForce: Bool) {
    let status = SecItemAdd(type.query as CFDictionary, nil)
    
    if status == errSecDuplicateItem {
      print("create - Duplicate")
      if isForce {
        update(type: type)
      }
    }
    
    if status == errSecSuccess {
      print("create -add success status = \(status)")
    } else {
      print("create -add false status = \(status)")
    }
  }
  
  public func read(type: KeychainRouter) -> String? {
    var item: AnyObject?
    let status = SecItemCopyMatching(type.readQuery as CFDictionary, &item)
    
    guard status != errSecItemNotFound else {
      print("Keychain read - item not found")
      return nil
    }
    
    guard status == errSecSuccess else {
      print("Keychain read - read error")
      return nil
    }

    guard let tokenData = item as? Data,
          let token = String(data: tokenData, encoding: .utf8) else {
      print("Keychain read - data error")
      return nil
    }

    return token
  }
  
  private func update(type: KeychainRouter) {
    let status = SecItemUpdate(type.query as CFDictionary, type.updateQuery as CFDictionary)
    
    if status == errSecSuccess {
      print("update - success staus = \(status)")
    } else {
      print("update - false staus = \(status)")
    }
  }

  public func delete(type: KeychainRouter) {
    let status = SecItemDelete(type.deleteQuery as CFDictionary)
    
    if status == errSecSuccess {
      print("delete - success status = \(status)")
    } else if status == errSecItemNotFound {
      print("delete - ItemNotFound  status = \(status)")
    } else {
      print("delete - false  status = \(status)")
    }
  }
}
