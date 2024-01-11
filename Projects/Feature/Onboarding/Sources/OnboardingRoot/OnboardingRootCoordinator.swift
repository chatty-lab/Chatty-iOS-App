//
//  OnboardingRootCoordinator.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared
import SharedDesignSystem

public final class OnboardingRootCoordinator: OnboardingRootCoordinatorProtocol {
  public weak var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .onboarding(.root)
  
  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let onboardingRootController = OnboardingRootController()
    onboardingRootController.delegate = self
    navigationController.pushViewController(onboardingRootController, animated: false)
  }
  
  public func presentToTerms() {
    let onboardingTermsController = OnboardingTermsController(reactor: OnboardingTermsReactor())
    onboardingTermsController.modalPresentationStyle = .pageSheet
    onboardingTermsController.delegate = self
    navigationController.present(onboardingTermsController, animated: true)
  }
  
  public func pushToLogin() {
    print("로그인")
  }
  
  deinit {
    print("해제됨: OnboardingRootCoordinator")
  }
}

extension OnboardingRootCoordinator: OnboardingTermsDelegate {
  public func signUp() {
    let onboardingPhoneAuthenticationCoordinator = OnboardingPhoneAuthenticationCoordinator(self.navigationController)
    
    childCoordinators.append(onboardingPhoneAuthenticationCoordinator)
    
    onboardingPhoneAuthenticationCoordinator.finishDelegate = self
    onboardingPhoneAuthenticationCoordinator.start()
  }
}

extension OnboardingRootCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Coordinator) {
    finish()
  }
}
