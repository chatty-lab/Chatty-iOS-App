//
//  LiveCoordinator.swift
//  FeatureLive
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared
import SharedDesignSystem

public final class LiveCoordinator: Coordinator {
  public var childViewControllers: Shared.ReferenceCounter = .init()
  
  public var navigationController: CustomNavigationController
  
  public var finishDelegate: CoordinatorFinishDelegate?
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .live
  
  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let liveController = LiveController()
    navigationController.pushViewController(liveController, animated: false)
  }
}
