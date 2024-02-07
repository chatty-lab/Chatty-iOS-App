//
//  SampleDIContainer.swift
//  Chatty
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainAuth
import DomainUser

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
      userAPIRepository: getUserAPIRepository(),
      userDataRepository: getUserDataRepository()
    )
  }
  
  // SignUseCase
  func getSignUserCase() -> DefaultSignUseCase {
    return DefaultSignUseCase(
      userAPIRepository: getUserAPIRepository(),
      keychainReposotory: getKeychainReposotory()
    )
  }
  
  // TokenUserCase
  func getTokenUserCase() -> DefaultTokenUseCase {
    return DefaultTokenUseCase(
      keychainRepository: getKeychainReposotory(),
      authAPIRepository: getAuthAPIRepository())
  }
  
  func getSendVerificationCodeUseCase() -> DefaultSendVerificationCodeUseCase {
    return DefaultSendVerificationCodeUseCase(
      authAPIRepository: getAuthAPIRepository(), 
      keychainRepository: getKeychainReposotory()
    )
  }

  // Repository
  func getUserAPIRepository() -> DefaultUserAPIRepository {
    return DefaultUserAPIRepository(userAPIService: UserAPIServiceImpl())
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
  
  func getAuthAPIRepository() -> DefaultAuthAPIRepository {
    return DefaultAuthAPIRepository(
      authAPIService: AuthAPIServiceImpl()
    )
  }
  
  func getTokenUseCase() -> DefaultTokenUseCase {
    return DefaultTokenUseCase(
      keychainRepository: getKeychainReposotory(),
      authAPIRepository: getAuthAPIRepository()
    )
  }
}
