//
//  FeatureOnboardingDIContainer.swift
//  Chatty
//
//  Created by HUNHIE LEE on 2/2/24.
//

import Foundation
import DomainAuth
import DomainUser
import DataNetwork
import DataRepository
import DataStorage
import FeatureOnboardingInterface

final class FeatureOnboardingDIContainer: RepositoryDIcontainer, FeatureOnboardingDependencyProvider {
  func makeSignUseCase() -> DefaultSignUseCase {
    return DefaultSignUseCase(
      userAPIRepository: makeUserAPIRepository(),
      keychainReposotory: makeKeychainRepository()
    )
  }
  
  func makeSendVerificationCodeUseCase() -> DefaultSendVerificationCodeUseCase {
    return DefaultSendVerificationCodeUseCase(
      authAPIRepository: makeAuthAPIRepository(), 
      keychainRepository: makeKeychainRepository()
    )
  }
  
  func makeGetDeviceIdUseCase() -> DefaultGetDeviceIdUseCase {
    return DefaultGetDeviceIdUseCase(
      keychainRepository: makeKeychainRepository()
    )
  }
  
  func makeSaveProfileNicknameUseCase() -> DefaultSaveProfileNicknameUseCase {
    return DefaultSaveProfileNicknameUseCase(
      userAPIRepository: makeUserAPIRepository(),
      userDataRepository: makeUserDataRepository()
    )
  }
  
  func makeSaveProfileDataUseCase() -> DefaultSaveProfileDataUseCase {
    return DefaultSaveProfileDataUseCase(
      userAPIRepository: makeUserAPIRepository(),
      userDataRepository: makeUserDataRepository()
    )
  }
  
  func makeGetProfileDataUseCase() -> DefaultGetUserDataUseCase {
    return DefaultGetUserDataUseCase(
      userAPIRepository: makeUserAPIRepository(),
      userDataRepository: makeUserDataRepository()
    )
  }
}
