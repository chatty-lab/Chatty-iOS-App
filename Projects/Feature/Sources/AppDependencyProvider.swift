//
//  AppDependencyProvider.swift
//  Feature
//
//  Created by HUNHIE LEE on 2/2/24.
//

import Foundation
import FeatureOnboardingInterface
import FeatureChatInterface
import DomainAuth
import DomainUser

public protocol AppDependencyProvider {
  func makeFeatureOnboardingDependencyProvider() -> FeatureOnboardingDependencyProvider
  func makeFeatureChatDependencyProvider() -> FeatureChatDependecyProvider
  
  func makeValiateAccessTokenUseCase() -> DefaultValidateAccessTokenUseCase
  func makeGetAccessTokenUseCase() -> DefaultGetAccessTokenUseCase
  func makeGetProfileUseCase() -> DefaultGetUserDataUseCase
}
