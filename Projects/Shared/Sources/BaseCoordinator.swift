//
//  BaseCoordinator.swift
//  Shared
//
//  Created by walkerhilla on 1/14/24.
//

import Foundation
import SharedDesignSystem

open class BaseCoordinator: Coordinator {
  public var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Coordinator] = []
  public var childViewControllers: ReferenceCounter = .init()
  open var type: CoordinatorType {
    return .app
  }
  
  public init(navigationController: CustomNavigationController) {
    self.navigationController = navigationController
    self.navigationController.customDelegate = self
  }
  
  open func start() {
    
  }
}

extension BaseCoordinator {
  public func setRootViewController(to coordinator: Coordinator, animated: Bool = true) {
    childCoordinators.removeAll()
    if let newRootViewController = coordinator.navigationController.viewControllers.first {
      navigationController.setViewControllers([newRootViewController], animated: animated)
    }
    addChildCoordinator(coordinator)
  }
  
  public func addChildCoordinator(_ childCoordinator: Coordinator) {
    childCoordinators.append(childCoordinator)
    childCoordinator.finishDelegate = self
  }
  
  public func removeChildCoordinator(_ childCoordinator: Coordinator) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === childCoordinator {
        childCoordinators.remove(at: index)
        break
      }
    }
  }
}

extension BaseCoordinator: CustomNavigationDelegate {
  public func pushViewController() {
    childViewControllers.increase()
  }
  
  public func popViewController() {
    childViewControllers.decrease()
    if childViewControllers.isReleased {
      finish()
    }
  }
}

extension BaseCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Coordinator) {
    self.removeChildCoordinator(childCoordinator)
    self.navigationController.customDelegate = self
  }
}
