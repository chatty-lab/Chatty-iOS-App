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
  public var childViewControllers: ChildViewController = .init()
  public var type: CoordinatorType = .onboarding(.profileUpdate(.profiles))
  
  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let profileState = OnboardingProfileReactor.State(state: .init(
      type: .gender,
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
    childViewControllers.increase()
  }
  
  public func presentModal() {
    let onboardingImageGuideContoller = OnboardingImageGuideController(reactor: OnboardingImageGuideReactor())

    onboardingImageGuideContoller.modalPresentationStyle = .pageSheet
    onboardingImageGuideContoller.delegate = self
    navigationController.present(onboardingImageGuideContoller, animated: true)
  }
  
  public func switchToMainTab() {
    print("profile - nil")
  }
  
  deinit {
    print("deinit - Onboarding Profile Coordinator")
  }
}

extension OnboardingProfileCoordinator: OnboardingImageGuideDelegate {
  public func pushToImagePicker() {
    print("profile - pushToImagePicker")
  }
}

extension OnboardingProfileCoordinator: BaseNavigationDelegate {
  public func popViewController() {
    childViewControllers.decrease()
    if childViewControllers.isFinished {
      finish()
    }
  }
}
