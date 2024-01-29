//
//  Storage.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/26/24.
//

import Foundation
import CoreStorage
import RxSwift

public protocol KeychainReposotoryProtocol {
  func requestCreat(type: KeychainRouter) -> Single<Bool>
  func requestRead(type: KeychainRouter) -> Single<String>
  func requestDelete(type: KeychainRouter) -> Single<Bool>
}

public final class DefaultKeychainReposotory: KeychainReposotoryProtocol {
  private var keychainService: KeychainService
  
  public init(keychainService: KeychainService) {
    self.keychainService = keychainService
  }
  
  public func requestCreat(type: KeychainRouter) -> Single<Bool> {
    return keychainService.creat(type: type, isForce: true)
  }
  
  public func requestRead(type: KeychainRouter) -> Single<String> {
    return .just("aaaddd")
//    return keychainService.read(type: type)
  }
  
  public func requestDelete(type: KeychainRouter) -> Single<Bool> {
    return keychainService.delete(type: type)
  }
  
}
