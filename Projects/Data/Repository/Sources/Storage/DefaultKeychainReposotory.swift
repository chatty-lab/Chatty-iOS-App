//
//  DefaultKeychainReposotory.swift
//  DataRepository
//
//  Created by 윤지호 on 1/26/24.
//

import Foundation
import RxSwift
import DataStorageInterface
import DataRepositoryInterface
import DomainCommon

public final class DefaultKeychainReposotory: KeychainReposotory {
  
  private var keychainService: any KeychainServiceProtocol
  
  public init(keychainService: any KeychainServiceProtocol) {
    self.keychainService = keychainService
  }
  
  public func requestCreate(type: KeychainCase) -> Single<Bool> {
    let request = KeychainRouter.toRouterCase(type: type)
    return keychainService.createSingle(type: request, isForce: true)
  }
  
  public func requestRead(type: KeychainCase) -> Single<String> {
    let request = KeychainRouter.toRouterCase(type: type)
    return keychainService.readSingle(type: request)
  }
  
  public func requestDelete(type: KeychainCase) -> Single<Bool> {
    let request = KeychainRouter.toRouterCase(type: type)
    return keychainService.deleteSingle(type: request)
  }
  
}
