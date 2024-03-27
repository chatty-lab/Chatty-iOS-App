//
//  KeychainService.swift
//  DataStorage
//
//  Created by 윤지호 on 1/17/24.
//

import Foundation
import DataStorageInterface
import RxSwift

public final class KeychainService: KeychainServiceProtocol {
  public static let shared = KeychainService()
  private init() { }

  /// isForce 강제로 중복된 keychain 내의 값을 업데이트 할것인지에 대한 Bool값 입니다.
  public func createSingle(type: KeychainRouter, isForce: Bool) -> Single<Bool> {
    let request = self.create(type: type, isForce: true)
    return .just(request)
  }
  
  public func readSingle(type: KeychainRouter) -> Single<String> {
    guard let result = self.read(type: type) else {
      return .just("")
    }
    return .just(result)
  }
  
  public func updateSingle(type: KeychainRouter) -> Single<Bool> {
    let result = self.update(type: type)
    return .just(result)
  }

  public func deleteSingle(type: KeychainRouter) -> Single<Bool> {
    let result = self.delete(type: type)
    return .just(result)
  }
}


extension KeychainService {
  public func create(type: KeychainRouter, isForce: Bool) -> Bool {
    let status = SecItemAdd(type.query as CFDictionary, nil)
    
    print(type.typeKey)
    print(type.readQuery)
    
    if status == errSecDuplicateItem {
      print("create - Duplicate - \(type.typeKey)")
      if isForce {
        return update(type: type)
      }
    }
    
    if status == errSecSuccess {
      print("create -add success status = \(status) - \(type.typeKey)")
      return true
    } else {
      print("create -add false status = \(status)")
      return false
    }
  }
  
  public func read(type: KeychainRouter) -> String? {
    var item: AnyObject?
    let status = SecItemCopyMatching(type.readQuery as CFDictionary, &item)
    
    print(type.typeKey)
    print(type.readQuery)
    
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
    
    print("키체인에서 꺼냈음!! \(token)")
    
    return token
  }
  
  public func update(type: KeychainRouter) -> Bool {
    let status = SecItemUpdate(type.query as CFDictionary, type.updateQuery as CFDictionary)
    
    if status == errSecSuccess {
      print("update - success staus = \(status)")
      return true
    } else {
      print("update - false staus = \(status)")
      return false
    }
    
    print("키체인 업데이트 \(type.query)")
  }

  public func delete(type: KeychainRouter) -> Bool {
    let status = SecItemDelete(type.deleteQuery as CFDictionary)
    
    if status == errSecSuccess {
      print("delete - success status = \(status)")
      return true
    } else if status == errSecItemNotFound {
      print("delete - ItemNotFound  status = \(status)")
      return false
    } else {
      print("delete - false  status = \(status)")
      return false
    }
  }
}
