//
//  OnboardingNickNameCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import UIKit
import Shared
import SharedDesignSystem

public final class OnboardingNickNameCoordinator: OnboardingNickNameCoordinatorProtocol {
  public var finishDelegate: Shared.CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Shared.Coordinator] = []
  public var type: Shared.CoordinatorType = .onboarding(.profileUpdate(.nickName))
  
  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let onboardingNickNameReactor = OnboardingNickNameReactor()
    let onboardingNickNameController = OnboardingNickNameController(reactor: onboardingNickNameReactor)
    onboardingNickNameController.delegate = self
    navigationController.pushViewController(onboardingNickNameController, animated: true)
  }
  
  public func pushToProfile(_ nickName: String) {
    let onboardingProfileCoordinator = OnboardingProfileCoordinator(navigationController)
    childCoordinators.append(onboardingProfileCoordinator)
    
    onboardingProfileCoordinator.finishDelegate = self
    onboardingProfileCoordinator.start()
  }
  
  deinit {
    print("deinit - Onboarding NickName Coordinator")
  }
}

extension OnboardingNickNameCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Shared.Coordinator) {
    
  }
}
