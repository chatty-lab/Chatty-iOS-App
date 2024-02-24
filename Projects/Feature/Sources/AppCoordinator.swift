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

public final class AppCoordinator: BaseCoordinator, AppFlowDelegate {
  public override var type: CoordinatorType {
    return .app
  }
  
  public var window: UIWindow
  
  private let featureDependencyProvider: FeatureDependencyProvider
  
  public init(window: UIWindow, navigationController: CustomNavigationController, featureDependencyProvider: FeatureDependencyProvider) {
    self.window = window
    self.featureDependencyProvider = featureDependencyProvider
    super.init(navigationController: navigationController)
    self.appFlowControl.delegete = self
  }
  
  public override func start() {
    showOnboardingFlow()
  }
  
  public func showOnboardingFlow() {
    let onboardingCoordinator = OnboardingRootCoordinator(
      navigationController: navigationController,
      dependencyProvider: featureDependencyProvider.makeFeatureOnboardingDependencyProvider()
    )
    childCoordinators.append(onboardingCoordinator)
    onboardingCoordinator.start()
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  public func showMainFlow() {
    navigationController.setViewControllers([], animated: false)
    let mainCoordinator = MainTabBarCoordinator(navigationController)

    childCoordinators.removeAll()
    childCoordinators.append(mainCoordinator)
    mainCoordinator.start()

    print("MainTab -->")
  }
  
  deinit {
    print("해제됨: AppCoordinator")
  }
}
