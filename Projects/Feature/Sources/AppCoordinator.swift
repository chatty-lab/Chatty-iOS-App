//
//  AppCoordinator.swift
//  Feature
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit
import Shared
import FeatureOnboarding

public final class AppCoordinator: Coordinator {
  public var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .app
  
  var window: UIWindow?
  
  public init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  public convenience init(window: UIWindow) {
    self.init(UINavigationController())
    self.window = window
    navigationController.setNavigationBarHidden(true, animated: true)
  }
  
  public func start() {
    let onboardingCoordinator = OnboardingRootCoordinator(self.navigationController)
    childCoordinators.append(onboardingCoordinator)
    
    onboardingCoordinator.finishDelegate = self
    onboardingCoordinator.start()
    
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}

extension AppCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Shared.Coordinator) {
    self.childCoordinators.removeAll()
    self.navigationController.viewControllers.removeAll()
    self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
}
