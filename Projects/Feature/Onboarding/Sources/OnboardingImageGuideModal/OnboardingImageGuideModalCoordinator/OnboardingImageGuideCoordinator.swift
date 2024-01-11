//
//  OnboardingImageGuideCoordinator.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//

import UIKit
import Shared
import SharedDesignSystem


public final class OnboardingImageGuideCoordinator: OnboardingImageGuideCoordinatorDelegate {
  public var onboardingImageGuideController: OnboardingImageGuideController
  public var finishDelegate: Shared.CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Shared.Coordinator] = []
  public var type: Shared.CoordinatorType = .myChatty
  public var imagePicker = UIImagePickerController()

  public init(onboardingImageGuideController: OnboardingImageGuideController, navigationController: CustomNavigationController) {
    self.onboardingImageGuideController = onboardingImageGuideController
    self.navigationController = navigationController
  }
  
  public func start() {
    onboardingImageGuideController.delegate = self
    onboardingImageGuideController.modalPresentationStyle = .pageSheet
    navigationController.present(onboardingImageGuideController, animated: true)
  }
  
  public func pushToAlbumView() {
    print("coordinator - album")
    
  }
  
  public func didFinishPick(_ image: UIImage?) {
    finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
  
}



extension OnboardingImageGuideCoordinator: CoordinatorFinishDelegate {
  public func coordinatorDidFinish(childCoordinator: Shared.Coordinator) {
    
  }
}
