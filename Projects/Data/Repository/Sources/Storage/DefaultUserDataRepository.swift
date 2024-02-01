//
//  DefaultUserDataRepository.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import DataStorageInterface
import DataRepositoryInterface
import DomainCommonInterface
import RxSwift

public final class DefaultUserDataRepository: UserDataRepository {
   
  private let userDataService: any UserDataServiceProtocol
  
  public init(userDataService: any UserDataServiceProtocol) {
    self.userDataService = userDataService
  }
  
  public func saveUserData(userData: UserData) {
    userDataService.setData(userData: userData)
  }
  
  public func getUserData() -> Single<UserData> {
    let data = userDataService.getData()
    return .just(data)
  }
}
