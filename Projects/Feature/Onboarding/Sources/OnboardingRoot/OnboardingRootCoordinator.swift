//
//  OnboardingRootCoordinator.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared

public final class OnboardingRootCoordinator: Coordinator {
  public var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var type: CoordinatorType = .onboarding
  
  public init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let onboardingRootController = OnboardingRootController()
    onboardingRootController.delegate = self
    navigationController.pushViewController(onboardingRootController, animated: false)
  }
}

extension OnboardingRootCoordinator: OnboardingRootControllerDelegate {
  func signUp() {
    let onboardingTermsController = OnboardingTermsController()
    onboardingTermsController.modalPresentationStyle = .pageSheet
    
    if let sheet = onboardingTermsController.sheetPresentationController {
      let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("customDetent")) { _ in
        return 322
      }
      sheet.detents = [customDetent]
      sheet.prefersScrollingExpandsWhenScrolledToEdge = false
    }
    
    navigationController.present(onboardingTermsController, animated: true)
  }
  
  func signIn() {
    
  }
}
