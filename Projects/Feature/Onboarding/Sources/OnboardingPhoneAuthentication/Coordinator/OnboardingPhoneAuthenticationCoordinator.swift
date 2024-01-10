//
//  OnboardingPhoneAuthenticationCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import Shared
import SharedDesignSystem

public final class OnboardingPhoneAuthenticationCoordinator: OnboardingPhoneAuthenticationCoordinatorProtocol {
  public weak var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Coordinator] = []
  public var childViewControllers: ChildViewController = .init()
  public var type: CoordinatorType = .onboarding(.auth)

  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
    navigationController.baseDelegate = self
  }
  
  deinit {
    print("해제됨: OnboardingPhoneAuthenticationCoordinator")
  }
  
  public func start() {
    let onboardingPhoneAuthenticationReactor = OnboardingPhoneAuthenticationReactor()
    let onboardingPhoneNumberEntryController = OnboardingPhoneNumberEntryController(reactor: onboardingPhoneAuthenticationReactor)
    onboardingPhoneNumberEntryController.delegate = self
    navigationController.pushViewController(onboardingPhoneNumberEntryController, animated: true)
    childViewControllers.increase()
  }
  
  public func pushToVerificationCodeEntryView(_ reactor: OnboardingPhoneAuthenticationReactor?) {
    guard let reactor else { return }
    let onboardingVerificationCodeEntryController = OnboardingVerificationCodeEntryController(reactor: reactor)
    navigationController.pushViewController(onboardingVerificationCodeEntryController, animated: true)
    childViewControllers.increase()
  }
}

extension OnboardingPhoneAuthenticationCoordinator: BaseNavigationDelegate {
  public func popViewController() {
    childViewControllers.decrease()
    if childViewControllers.isFinished {
      finish()
    }
  }
}
