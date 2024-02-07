//
//  OnboardingRootDelegate.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import Shared

public protocol OnboardingRootDelegate: AnyObject {
  func presentToTerms()
  func pushToSignIn()
  func pushToSignUp()
}
