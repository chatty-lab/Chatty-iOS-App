//
//  Coordinator.swift
//  Shared
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit
import SharedDesignSystem

public protocol Coordinator: AnyObject {
  var finishDelegate: CoordinatorFinishDelegate? { get set }
  var navigationController: CustomNavigationController { get set }
  var childCoordinators: [Coordinator] { get set }
  var childViewControllers: ReferenceCounter { get set }
  var type: CoordinatorType { get }
  
  func start()
  func finish()
  func removeChildCoordinator(_ childCoordinator: Coordinator)
}

extension Coordinator {
  public func finish() {
    childCoordinators.removeAll()
    finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
  
  public func removeChildCoordinator(_ childCoordinator: Coordinator) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === childCoordinator {
        childCoordinators.remove(at: index)
        break
      }
    }
  }
  
  public func coordinatorDidFinish(childCoordinator: Coordinator) {
    self.removeChildCoordinator(childCoordinator)
    self.navigationController.customDelegate = self as? any CustomNavigationDelegate
  }
  
  public func popViewController() {
    childViewControllers.decrease()
    if childViewControllers.isReleased {
      finish()
    }
  }
}

public protocol CoordinatorFinishDelegate: AnyObject {
  func coordinatorDidFinish(childCoordinator: Coordinator)
}
