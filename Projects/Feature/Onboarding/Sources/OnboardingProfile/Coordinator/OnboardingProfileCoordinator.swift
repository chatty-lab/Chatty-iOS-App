//
//  OnboardingProfileCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import Shared

public final class OnboardingProfileCoordinator: OnboardingProfileCoordinatorProtocol {
  public var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var onboardingProfileController: OnboardingProfileController
  public var type: CoordinatorType = .onboarding(.profileUpdate(.profiles))
  private var onboardingProfileCoordinatorTump: OnboardingProfileCoordinator?
  private var onboardingImageGuideCoordinator: OnboardingImageGuideCoordinator?
  
  public init(_ navigationController: UINavigationController, _ onboardingProfileCoordinator: OnboardingProfileController) {
    self.navigationController = navigationController
    self.onboardingProfileController = onboardingProfileCoordinator
  }
  
  public func start() {
    onboardingProfileController.delegate = self
    navigationController.pushViewController(onboardingProfileController, animated: true)
  }
  
  public func pushToNextView(_ state: ProfileState) {
    var state = state
    state.type = state.type.nextViewType
    let profileState = OnboardingProfileReactor.State(state: state)
    
    self.onboardingProfileCoordinatorTump = OnboardingProfileCoordinator(navigationController, OnboardingProfileController(reactor: OnboardingProfileReactor(profileState)))
    onboardingProfileCoordinatorTump?.finishDelegate = self
    onboardingProfileCoordinatorTump?.start()
  }
  
  public func presentModal() {
    print("hi -> coordinator 2")
    self.onboardingImageGuideCoordinator = OnboardingImageGuideCoordinator(onboardingImageGuideController: OnboardingImageGuideController(reactor: OnboardingImageGuideReactor()), navigationController: navigationController)

    
    onboardingImageGuideCoordinator?.finishDelegate = self
    onboardingImageGuideCoordinator?.start()
    
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
