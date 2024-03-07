//
//  DefaultUserDataRepository.swift
//  DataRepository
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift
import DataStorageInterface
import DataRepositoryInterface
import DomainUserInterface

public final class DefaultUserDataRepository: UserDataRepository {
  
  private let userDataService: any UserDataServiceProtocol
  
  public init(userDataService: any UserDataServiceProtocol) {
    self.userDataService = userDataService
  }
  
  public func saveUserData(userData: UserDataProtocol) {
    userDataService.setData(userData: userData)
  }
  
  public func getUserData() -> UserDataProtocol {
    return userDataService.getData()
  }
  
  public func saveAllInterests(interests: Interests) {
    userDataService.saveAllInterests(interests: interests)
  }
}
