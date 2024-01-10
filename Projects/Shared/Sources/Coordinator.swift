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
//  var childViewControllers: [UIViewController] { get set }
  var type: CoordinatorType { get set }
  
  func start()
  func finish()
}

extension Coordinator {
  public func finish() {
    childCoordinators.removeAll()
    finishDelegate?.coordinatorDidFinish(childCoordinator: self)
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
