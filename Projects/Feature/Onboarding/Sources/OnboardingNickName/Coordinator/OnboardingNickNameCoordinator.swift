//
//  OnboardingNickNameCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import UIKit
import Shared
import SharedDesignSystem

public final class OnboardingNickNameCoordinator: OnboardingNickNameCoordinatorProtocol, CoordinatorFinishDelegate, BaseNavigationDelegate {
  public weak var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Coordinator] = []
  public var childViewControllers: ChildViewController = .init()
  public var type: CoordinatorType = .onboarding(.profileUpdate(.nickName))
  
  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
    navigationController.baseDelegate = self
  }
  
  public func start() {
    let onboardingNickNameReactor = OnboardingNickNameReactor()
    let onboardingNickNameController = OnboardingNickNameController(reactor: onboardingNickNameReactor)
    onboardingNickNameController.delegate = self
    navigationController.pushViewController(onboardingNickNameController, animated: true)
    childViewControllers.increase()
  }
  
  public func pushToProfiles() {
    let onboardingProfileCoordinator = OnboardingProfileCoordinator(self.navigationController)
    
    childCoordinators.append(onboardingProfileCoordinator)
    
    onboardingProfileCoordinator.finishDelegate = self
    onboardingProfileCoordinator.start()
  }
  
  deinit {
    print("해제됨: NickName Coordinator")
  }
}
