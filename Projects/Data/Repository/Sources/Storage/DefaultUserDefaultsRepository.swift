//
//  DefaultUserDefaultsRepository.swift
//  DataRepository
//
//  Created by 윤지호 on 1/28/24.
//

import Foundation
import RxSwift
import DataStorageInterface
import DataRepositoryInterface
import DomainCommon

public final class DefaultUserDefaultsRepository: UserDefaultsRepository {
  private let userDefaultService: any UserDefaultsServiceProtocol
  
  public init(userDefaultService: any UserDefaultsServiceProtocol) {
    self.userDefaultService = userDefaultService
  }
  
  public func requestCreate(type: UserDefaultsCase) {
    userDefaultService.creat(type: UserDefaultsRouter.toRouterCase(type: type))
  }
  
  public func requestRead<T>(type: UserDefaultsCase) -> T? {
    return userDefaultService.read(type: UserDefaultsRouter.toRouterCase(type: type))
  }
  
  public func requestDelete(type: UserDefaultsCase) {
    return userDefaultService.delete(type: UserDefaultsRouter.toRouterCase(type: type))
  }
}
