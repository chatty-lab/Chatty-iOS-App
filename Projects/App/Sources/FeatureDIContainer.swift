//
//  FeatureDIContainer.swift
//  Chatty
//
//  Created by HUNHIE LEE on 2/2/24.
//

import Foundation
import Feature
import FeatureOnboardingInterface
import FeatureLiveInterface
import FeatureProfileInterface

import DomainCommon
import DomainUser
import DomainAuth
import DataRepository
import DataNetwork
import DataStorage

final class FeatureDIContainer: RepositoryDIcontainer, FeatureDependencyProvider {
  static let shared: FeatureDIContainer = FeatureDIContainer()
  
  private init() { }
  
  func makeFeatureOnboardingDependencyProvider() -> FeatureOnboardingDependencyProvider {
    return FeatureOnboardingDIContainer()
  }
  
  func makeFeatureLiveDependencyProvider() -> FeatureLiveDependencyProvider {
    return FeatureLiveDIcontainer()
  }
  
  func makeFeatureProfileDependencyProvider() -> FeatureProfileDependencyProvider {
    return FeatureProfileDIContainer()
  }
  
  func makeDefaultSaveDeviceTokenUseCase() -> DefaultSaveDeviceTokenUseCase {
    return DefaultSaveDeviceTokenUseCase(keychainRepository: makeKeychainRepository())
  }
  
  func makeDefaultSaveDeviceIdUseCase() -> DefaultSaveDeviceIdUseCase {
    return DefaultSaveDeviceIdUseCase(keychainRepository: makeKeychainRepository())
  }
  
  func makeDefaultGetDeviceIdUseCase() -> DefaultGetDeviceIdUseCase {
    return DefaultGetDeviceIdUseCase(keychainRepository: makeKeychainRepository())
  }
}
