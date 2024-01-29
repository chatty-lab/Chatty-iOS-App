//
//  UserDefaultsRepository.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/28/24.
//

import Foundation
import CoreStorage
import CoreRepositoryInterface
import RxSwift

public final class DefaultUserDefaultsRepository: UserDefaultsRepositoryProtocol {
  private let userDefaultService: UserDefaultsService
  
  init(userDefaultService: UserDefaultsService) {
    self.userDefaultService = userDefaultService
  }
  
  public func requestCreat(type: String) {
    userDefaultService.creat(type: .exampleString(""))
  }
  
  public func requestRead<T>(type: String) -> Observable<T?> {
    return userDefaultService.read(type: .exampleString(""))
  }
  
  public func requestDelete(type: String) {
    return userDefaultService.delete(type: .exampleString(""))
  }
}
