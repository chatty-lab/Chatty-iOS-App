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

final class FeatureOnboardingDIContainer: FeatureOnboardingDependencyProvider {
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
}

// Repository Builder
extension FeatureOnboardingDIContainer {
  private func makeUserAPIRepository() -> DefaultUserAPIRepository {
    return DefaultUserAPIRepository(userAPIService: UserAPIServiceImpl(), profileAPIService: ProfileAPIServiceImpl())
  }
  
  private func makeAuthAPIRepository() -> DefaultAuthAPIRepository {
    return DefaultAuthAPIRepository(authAPIService: AuthAPIServiceImpl())
  }
  
  private func makeKeychainRepository() -> DefaultKeychainReposotory {
    return DefaultKeychainReposotory(keychainService: KeychainService.shared)
  }
}
