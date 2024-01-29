//
//  UserDataRepository.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import CoreStorage
import CoreNetwork
import CoreRepositoryInterface
import DomainCommonInterface
import RxSwift

public final class DefaultUserDataRepository: UserDataRepositoryProtocol {
   
  private let userDataService: UserDataService
  
  public init(userDataService: UserDataService) {
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
