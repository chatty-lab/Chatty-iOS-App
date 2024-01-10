//
//  AppCoordinator.swift
//  Feature
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit
import Shared
import SharedDesignSystem
import FeatureOnboarding

protocol AppCoordinatorProtocol: Coordinator {
  func showOnboardingFlow()
  func showMainFlow()
}

public final class AppCoordinator: AppCoordinatorProtocol {
  public weak var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .app
  
  var window: UIWindow
  
  public init(window: UIWindow, _ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
    self.window = window
  }
  
  public func start() {
    showOnboardingFlow()
  }
  
  func showOnboardingFlow() {
    let onboardingCoordinator = OnboardingRootCoordinator(navigationController)
    childCoordinators.append(onboardingCoordinator)
    onboardingCoordinator.start()
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  func showMainFlow() {
    
  }
  
  deinit {
    print("해제됨: AppCoordinator")
  }
}
