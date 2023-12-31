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
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: BaseNavigationController
  var childCoordinators: [Coordinator] = []
  var type: CoordinatorType = .tab
  
  var tabBarController: UITabBarController
  
  init(_ navigationController: BaseNavigationController) {
    self.navigationController = navigationController
    self.tabBarController = UITabBarController()
  }
  
  func start() {
    let liveTabCoordinator = LiveCoordinator(BaseNavigationController())
    liveTabCoordinator.start()
    
    let tabBarController = MainTabBarController(tabNavigationControllers: [
      .live: liveTabCoordinator.navigationController
    ])
    
    navigationController.pushViewController(tabBarController, animated: false)
  }
}
