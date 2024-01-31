//
//  Storage.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/26/24.
//

import Foundation
import CoreStorage
import CoreRepositoryInterface
import DomainCommonInterface
import RxSwift

public final class DefaultKeychainReposotory: KeychainReposotoryProtocol {
  
  private var keychainService: KeychainService
  
  public init(keychainService: KeychainService) {
    self.keychainService = keychainService
  }
  
  public func requestCreat(type: KeychainCase) -> Single<Bool> {
    let request = KeychainRouter.toRouterCase(type: type)
    return keychainService.creat(type: request, isForce: true)
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
