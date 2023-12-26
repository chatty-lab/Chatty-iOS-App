//
//  LiveCoordinator.swift
//  FeatureLive
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared

public final class LiveCoordinator: Coordinator {
  public var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .live
  
  public init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let liveController = LiveController()
    navigationController.pushViewController(liveController, animated: false)
  }
}
