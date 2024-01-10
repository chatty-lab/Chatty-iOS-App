//
//  OnboardingPhoneAuthenticationCoordinatorProtocol.swift
//  FeatureOnboardingInterface
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import Shared

public protocol OnboardingPhoneAuthenticationCoordinatorProtocol: Coordinator {
  func pushToVerificationCodeEntryView(_ reactor: OnboardingPhoneAuthenticationReactor?)
}
