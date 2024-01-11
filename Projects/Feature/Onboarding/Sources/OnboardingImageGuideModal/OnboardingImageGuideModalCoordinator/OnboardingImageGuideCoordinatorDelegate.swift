//
//  OnboardingImageGuideModalCoordinatorDelegate.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//

import UIKit
import Shared

public protocol OnboardingImageGuideCoordinatorDelegate: Coordinator {
  var onboardingImageGuideController: OnboardingImageGuideController { get set }
  
  func pushToAlbumView()
  func didFinishPick(_ image: UIImage?)
}
