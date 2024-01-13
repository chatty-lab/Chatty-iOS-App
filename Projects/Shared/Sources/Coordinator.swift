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
  var childViewControllers: ChildViewController { get set }
  var type: CoordinatorType { get set }
  
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
    self.navigationController.baseDelegate = self as? any BaseNavigationDelegate
  }
  
  public func popViewController() {
    childViewControllers.decrease()
    if childViewControllers.isFinished {
      finish()
    }
  }
}

public protocol CoordinatorFinishDelegate: AnyObject {
  func coordinatorDidFinish(childCoordinator: Coordinator)
}

public struct ChildViewController {
  public var count: Int = 0
  
  public var isFinished: Bool {
    return count < 1
  }
  
  public init() { }
  
  public mutating func increase() {
    count += 1
  }
  
  public mutating func decrease() {
    count -= 1
  }
}
