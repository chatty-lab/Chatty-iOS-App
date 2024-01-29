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
  public var childViewControllers: ChildViewController = .init()
  open var type: CoordinatorType {
    return .app
  }
  
  public init(navigationController: CustomNavigationController) {
    self.navigationController = navigationController
  }
  
  open func start() {
    
  }
}

extension BaseCoordinator {
  public func removeChildCoordinator(_ childCoordinator: Coordinator) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === childCoordinator {
        childCoordinators.remove(at: index)
        break
      }
    }
  }
}

extension BaseCoordinator: BaseNavigationDelegate {
  public func popViewController() {
    childViewControllers.decrease()
    if childViewControllers.isFinished {
      finish()
    }
  }
}

extension BaseCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Coordinator) {
    self.removeChildCoordinator(childCoordinator)
    self.navigationController.baseDelegate = self
  }
}
