//
//  TempDIContainer.swift
//  Chatty
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainAuth
import DomainUser
import DomainCommonInterface

import CoreRepository
import CoreNetwork
import CoreStorage

public final class SampleDIContainer {
  static let shared = SampleDIContainer()
  private init() { }
  
  // SaveProfileUseCase
  func getSaveProfileUseCase() -> DefaultSaveProfileUseCase {
    return DefaultSaveProfileUseCase(
      userApiRepository: getUserAPIRepository(),
      userDataRepository: getUserDataRepository()
    )
  }
  
  // SignUseCase
  func getSignUserCase() -> DefaultSignUseCase {
    return DefaultSignUseCase(
      userApiRepository: getUserAPIRepository(),
      keychainReposotory: getKeychainReposotory(),
      tokenUseCase: getTokenUseCase()
    )
  }
  
  // TokenUserCase
  func getTokenUserCase() -> DefaultTokenUseCase {
    return DefaultTokenUseCase(
      keychainRepository: getKeychainReposotory(),
      authAPIRepository: getAuthApiRepository())
  }
  
  
  // Repository
  
  func getUserAPIRepository() -> DefaultUserApiRepository<UserAPIRouter> {
    return DefaultUserApiRepository<UserAPIRouter>(userAPIService: UserAPIService())
  }
  
  func getUserDataRepository() -> DefaultUserDataRepository {
    return DefaultUserDataRepository(
      userDataService: UserDataService.shared
    )
  }
  
  func getKeychainReposotory() -> DefaultKeychainReposotory {
    return DefaultKeychainReposotory(
      keychainService: KeychainService.shared
    )
  }
  
  func getAuthApiRepository() -> DefaultAuthApiRepository<AuthAPIRouter> {
    return DefaultAuthApiRepository(
      authAPIService: AuthAPIService()
    )
  }
  
  func getTokenUseCase() -> DefaultTokenUseCase {
    return DefaultTokenUseCase(
      keychainRepository: getKeychainReposotory(),
      authAPIRepository: getAuthApiRepository()
    )
  }
}
