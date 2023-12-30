//
//  OnboardingRootCoordinator.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared

public final class OnboardingRootCoordinator: OnboardingRootCoordinatorProtocol {
  public weak var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .onboarding(.root)
  public var onboardingRootController: OnboardingRootController
  
  public init(_ navigationController: UINavigationController, _ controller: OnboardingRootController) {
    self.navigationController = navigationController
    self.onboardingRootController = controller
  }
  
  public func start() {
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
  func signUp() {
    navigationController.dismiss(animated: true)
    let onboardingAuthCoordinator = OnboardingAuthCoordinator(navigationController, onboardingAuthController: OnboardingAuthController())
    onboardingAuthCoordinator.finishDelegate = self
    onboardingAuthCoordinator.start()
  }
}

extension OnboardingRootCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Coordinator) {
    
  }
}
