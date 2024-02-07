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

protocol AppCoordinatorProtocol {
  func showOnboardingFlow()
  func showMainFlow()
}

public final class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol {
  public override var type: CoordinatorType {
    return .app
  }
  
  public var window: UIWindow
  
  private let featureDependencyProvider: FeatureDependencyProvider
  
  public init(window: UIWindow, navigationController: CustomNavigationController, featureDependencyProvider: FeatureDependencyProvider) {
    self.window = window
    self.featureDependencyProvider = featureDependencyProvider
    super.init(navigationController: navigationController)
  }
  
  public override func start() {
    showOnboardingFlow()
  }
  
  func showOnboardingFlow() {
    let onboardingCoordinator = OnboardingRootCoordinator(
      navigationController: navigationController,
      dependencyProvider: featureDependencyProvider.makeFeatureOnboardingDependencyProvider()
    )
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
