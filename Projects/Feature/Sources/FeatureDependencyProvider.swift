//
//  FeatureDependencyProvider.swift
//  Feature
//
//  Created by HUNHIE LEE on 2/2/24.
//

import Foundation
import FeatureOnboardingInterface

public protocol FeatureDependencyProvider {
  func makeFeatureOnboardingDependencyProvider() -> FeatureOnboardingDependencyProvider
}
