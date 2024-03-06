//
//  MainTabBarCoordinator.swift
//  Feature
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit
import Shared
import SharedDesignSystem
import FeatureLive

final class MainTabBarCoordinator: Coordinator {
  var childViewControllers: ReferenceCounter = .init()
  
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: CustomNavigationController
  var childCoordinators: [Coordinator] = []
  var type: CoordinatorType = .tab
  
  var tabBarController: UITabBarController
  
  private let featureDependencyProvider: FeatureDependencyProvider
  
  init(_ navigationController: CustomNavigationController, featureDependencyProvider: FeatureDependencyProvider) {
    self.navigationController = navigationController
    self.featureDependencyProvider = featureDependencyProvider
    self.tabBarController = UITabBarController()
  }
  
  func start() {
    let liveTabCoordinator = LiveMainCoordinator(
      navigationController: CustomNavigationController(),
      featureLiveDependencyProvider: featureDependencyProvider.makeFeatureLiveDependencyProvider()
    )
    liveTabCoordinator.start()
    
    let tabBarController = MainTabBarController(tabNavigationControllers: [
      .live: liveTabCoordinator.navigationController
    ])
    
    navigationController.pushViewController(tabBarController, animated: false)
  }
}
