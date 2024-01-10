//
//  OnboardingNickNameCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import UIKit
import Shared

public final class OnboardingNickNameCoordinator: OnboardingNickNameCoordinatorProtocol {
  public var finishDelegate: Shared.CoordinatorFinishDelegate?
  public var navigationController: UINavigationController
  public var childCoordinators: [Shared.Coordinator] = []
  public var onboardingNickNameController: OnboardingNickNameController
  public var type: Shared.CoordinatorType = .onboarding(.profileUpdate(.nickName))
  private var onboardingProfileCoordinator: OnboardingProfileCoordinator?
  
  public init(_ navigationController: UINavigationController, _ onboardingNickNameController: OnboardingNickNameController) {
    self.navigationController = navigationController
    self.onboardingNickNameController = onboardingNickNameController
  }
  
  public func start() {
    onboardingNickNameController.delegate = self
    navigationController.pushViewController(onboardingNickNameController, animated: true)
  }
  
  public func pushToProfile(_ nickName: String) {
    let profileState = OnboardingProfileReactor.State(state: .init(
      type: .gender,
      nickName: nickName,
      gender: .none, 
      porfileImage: UIImage(),
      birth: Date(),
      mbti: .init())
    )
    
    self.onboardingProfileCoordinator = OnboardingProfileCoordinator(navigationController, OnboardingProfileController(reactor: OnboardingProfileReactor(profileState)))
    
    self.onboardingProfileCoordinator?.finishDelegate = self
    self.onboardingProfileCoordinator?.start()
  }
  
  deinit {
    print("deinit - Onboarding NickName Coordinator")
  }
}

extension OnboardingNickNameCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Shared.Coordinator) {
    
  }
}
