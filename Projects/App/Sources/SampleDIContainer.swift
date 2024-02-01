//
//  SampleDIContainer.swift
//  Chatty
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainAuth
import DomainUser
import DomainCommonInterface

import DataNetwork
import DataNetworkInterface
import DataRepository
import DataStorage

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
  
  func getUserAPIRepository() -> DefaultUserAPIRepository<UserAPIRouter> {
    return DefaultUserAPIRepository<UserAPIRouter>(userAPIService: UserAPIServiceImpl())
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
  
  func getAuthApiRepository() -> DefaultAuthAPIRepository<AuthAPIRouter> {
    return DefaultAuthAPIRepository(
      authAPIService: AuthAPIServiceImpl()
    )
  }
  
  func getTokenUseCase() -> DefaultTokenUseCase {
    return DefaultTokenUseCase(
      keychainRepository: getKeychainReposotory(),
      authAPIRepository: getAuthApiRepository()
    )
  }
}
