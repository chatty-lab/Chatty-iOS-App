//
//  UserDefaultsRepository.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/28/24.
//

import Foundation
import CoreStorage
import RxSwift

public protocol UserDefaultsRepositoryProtocol {
  func requestCreat(type: UserDefaultsRouter)
  func requestRead<T>(type: UserDefaultsRouter) -> Observable<T?>
  func requestDelete(type: UserDefaultsRouter)
}

public final class DefaultUserDefaultsRepository: UserDefaultsRepositoryProtocol {
  private let userDefaultService: UserDefaultsService
  
  init(userDefaultService: UserDefaultsService) {
    self.userDefaultService = userDefaultService
  }
  
  public func requestCreat(type: UserDefaultsRouter) {
    userDefaultService.creat(type: type)
  }
  
  public func requestRead<T>(type: UserDefaultsRouter) -> Observable<T?> {
    return userDefaultService.read(type: type)
  }
  
  public func requestDelete(type: UserDefaultsRouter) {
    return userDefaultService.delete(type: type)
  }
}
