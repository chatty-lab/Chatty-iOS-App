//
//  OnboardingProfileCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import Shared
import SharedDesignSystem

public final class OnboardingProfileCoordinator: OnboardingProfileCoordinatorProtocol {
  public var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .onboarding(.profileUpdate(.profiles))
  
  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let profileState = OnboardingProfileReactor.State(state: .init(
      type: .profileImage,
      nickName: "nickName",
      gender: .none,
      porfileImage: UIImage(),
      birth: Date(),
      mbti: .init())
    )
    let onboardingProfileReactor = OnboardingProfileReactor(profileState)
    let onboardingProfileController = OnboardingProfileController(reactor: onboardingProfileReactor)
    onboardingProfileController.delegate = self
    navigationController.pushViewController(onboardingProfileController, animated: true)
  }
  
  public func pushToNextView(_ state: ProfileState) {
    var state = state
    state.type = state.type.nextViewType
    let profileState = OnboardingProfileReactor.State(state: state)
    let onboardingProfileReator = OnboardingProfileReactor(profileState)
    let onboardingProfileController = OnboardingProfileController(reactor: onboardingProfileReator)
    onboardingProfileController.delegate = self
    navigationController.pushViewController(onboardingProfileController, animated: true)
  }
  
  public func presentModal() {
    print("hi -> coordinator 2")
    let onboardingImageGuideCoordinator = OnboardingImageGuideCoordinator(onboardingImageGuideController: OnboardingImageGuideController(reactor: OnboardingImageGuideReactor()), navigationController: navigationController)
    childCoordinators.append(onboardingImageGuideCoordinator)
    onboardingImageGuideCoordinator.finishDelegate = self
    onboardingImageGuideCoordinator.start()
  }
  
  
  public func switchToMainTab() {
    print("profile - nil")
  }
  
  deinit {
    print("deinit - Onboarding Profile Coordinator")
  }
}

extension OnboardingProfileCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Shared.Coordinator) {
    for (index, coordinator) in childCoordinators.enumerated() {
      
      if coordinator === childCoordinator {
        childCoordinators.remove(at: index)
        break
      }
    }
  }
}
