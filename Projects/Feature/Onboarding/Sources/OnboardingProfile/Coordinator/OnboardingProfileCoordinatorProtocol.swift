//
//  OnboardingProfileCoordinatorProtocol.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import Foundation
import Shared

public protocol OnboardingProfileCoordinatorProtocol: Coordinator {
  func pushToNextView(_ state: ProfileState)
  func presentModal()
  func switchToMainTab()
}
