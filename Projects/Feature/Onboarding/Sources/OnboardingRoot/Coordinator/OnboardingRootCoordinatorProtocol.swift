//
//  OnboardingRootCoordinatorProtocol.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import Shared

public protocol OnboardingRootCoordinatorProtocol: Coordinator {
  func presentToTerms()
  func pushToLogin()
}