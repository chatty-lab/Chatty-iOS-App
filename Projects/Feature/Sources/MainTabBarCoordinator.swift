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
import FeatureChat
import FeatureChatInterface

final class MainTabBarCoordinator: BaseCoordinator {
  override var type: CoordinatorType {
   return .tab
  }
  
  private let featureChatDependencyProvider: FeatureChatDependecyProvider
  
  public init(_ navigationController: CustomNavigationController, featureChatDependencyProvider: FeatureChatDependecyProvider) {
    self.featureChatDependencyProvider = featureChatDependencyProvider
    super.init(navigationController: navigationController)
  }
  
  override func start() {
    let liveTabCoordinator = LiveCoordinator(CustomNavigationController())
    liveTabCoordinator.start()
    
    let chatTabCoordinator = ChatCoordinator(navigationController: CustomNavigationController(), dependencyProvider: featureChatDependencyProvider)
    chatTabCoordinator.start()
    
    let tabBarController = MainTabBarController(tabNavigationControllers: [
      .live: liveTabCoordinator.navigationController,
      .chat: chatTabCoordinator.navigationController
    ])
    
    childCoordinators.append(liveTabCoordinator)
    childCoordinators.append(chatTabCoordinator)
    
    navigationController.setViewControllers([tabBarController], animated: false)
  }
}
