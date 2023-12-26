//
//  OnboardingCoordinator.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared

public final class OnboardingCoordinator: Coordinator {
  public var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .onboarding
  
  public init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let onboardingController = OnboardingController()
    navigationController.pushViewController(onboardingController, animated: false)
  }
}
