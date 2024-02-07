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

public final class DefaultUserDefaultsRepository: UserDefaultsRepository {
  private let userDefaultService: any UserDefaultsServiceProtocol
  
  init(userDefaultService: any UserDefaultsServiceProtocol) {
    self.userDefaultService = userDefaultService
  }
  
  public func requestCreate(type: String) {
    userDefaultService.creat(type: .exampleString(""))
  }
  
  public func requestRead<T>(type: String) -> Observable<T?> {
    return userDefaultService.read(type: .exampleString(""))
  }
  
  public func requestDelete(type: String) {
    return userDefaultService.delete(type: .exampleString(""))
  }
}
