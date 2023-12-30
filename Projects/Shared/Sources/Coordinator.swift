//
//  Coordinator.swift
//  Shared
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit

public protocol Coordinator: AnyObject {
  var finishDelegate: CoordinatorFinishDelegate? { get set }
  var navigationController: UINavigationController { get set }
  var childCoordinators: [Coordinator] { get set }
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
