//
//  OnboardingNickNameCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import UIKit
import Shared
import SharedDesignSystem

public final class OnboardingNickNameCoordinator: BaseCoordinator, OnboardingNickNameCoordinatorProtocol {
  public override var type: CoordinatorType {
    .onboarding(.profileUpdate(.nickName))
  }
  
  public override func start() {
    let onboardingNickNameReactor = OnboardingNickNameReactor()
    let onboardingNickNameController = OnboardingNickNameController(reactor: onboardingNickNameReactor)
    onboardingNickNameController.delegate = self
    navigationController.pushViewController(onboardingNickNameController, animated: true)
  }
  
  public func pushToProfiles() {
    let onboardingProfileCoordinator = OnboardingProfileCoordinator(navigationController: self.navigationController)
    
    childCoordinators.append(onboardingProfileCoordinator)
    
    onboardingProfileCoordinator.finishDelegate = self
    onboardingProfileCoordinator.start()
  }
  
  deinit {
    print("해제됨: NickName Coordinator")
  }
}
