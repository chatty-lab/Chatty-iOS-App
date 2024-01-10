//
//  OnboardingNickNameProtocol.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import UIKit
import Shared

public protocol OnboardingNickNameCoordinatorProtocol: Coordinator {
  var onboardingNickNameController: OnboardingNickNameController { get set }
  
  func pushToProfile(_ nickName: String)
}
