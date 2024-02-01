//
//  DefaultKeychainReposotory.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/26/24.
//

import Foundation
import DataStorageInterface
import DataRepositoryInterface
import DomainCommonInterface
import RxSwift

public final class DefaultKeychainReposotory: KeychainReposotory {
  
  private var keychainService: any KeychainServiceProtocol
  
  public init(keychainService: any KeychainServiceProtocol) {
    self.keychainService = keychainService
  }
  
  public func requestCreat(type: KeychainCase) -> Single<Bool> {
    let request = KeychainRouter.toRouterCase(type: type)
    return keychainService.create(type: request, isForce: true)
  }
  
  public func requestRead(type: KeychainCase) -> Single<String> {
    let request = KeychainRouter.toRouterCase(type: type)
      return keychainService.read(type: request)
  }
  
  public func requestDelete(type: KeychainCase) -> Single<Bool> {
    let request = KeychainRouter.toRouterCase(type: type)
    return keychainService.delete(type: request)
  }
  
}
