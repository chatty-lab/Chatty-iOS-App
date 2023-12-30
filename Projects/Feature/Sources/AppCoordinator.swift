//
//  AppCoordinator.swift
//  Feature
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit
import Shared
import FeatureOnboarding

protocol AppCoordinatorProtocol: Coordinator {
  func showOnboardingFlow()
  func showMainFlow()
}

public final class AppCoordinator: AppCoordinatorProtocol {
  public weak var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .app
  
  var window: UIWindow
  
  public init(window: UIWindow, _ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.window = window
  }
  
  public func start() {
    showOnboardingFlow()
  }
  
  func showOnboardingFlow() {
    let onboardingCoordinator = OnboardingRootCoordinator(self.navigationController, OnboardingRootController())
    childCoordinators.append(onboardingCoordinator)
    
    onboardingCoordinator.finishDelegate = self
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

extension AppCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Coordinator) {
    self.childCoordinators.removeAll()
    self.navigationController.viewControllers.removeAll()
    self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
}
