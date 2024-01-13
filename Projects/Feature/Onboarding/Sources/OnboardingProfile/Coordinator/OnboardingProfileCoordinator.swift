//
//  OnboardingProfileCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import PhotosUI
import Shared
import SharedDesignSystem

public final class OnboardingProfileCoordinator: Coordinator, BaseNavigationDelegate {
  public weak var finishDelegate: CoordinatorFinishDelegate?
  public var navigationController: CustomNavigationController
  public var childCoordinators: [Coordinator] = []
  public var childViewControllers: ChildViewController = .init()
  public var type: CoordinatorType = .onboarding(.profileUpdate(.profiles))
  
  public init(_ navigationController: CustomNavigationController) {
    self.navigationController = navigationController
    navigationController.baseDelegate = self
  }
  
  public func start() {
    let profileState = OnboardingProfileReactor.State(state: .gender)
    let onboardingProfileReactor = OnboardingProfileReactor(profileState)
    let onboardingProfileController = OnboardingProfileController(reactor: onboardingProfileReactor)
    onboardingProfileController.delegate = self
    navigationController.pushViewController(onboardingProfileController, animated: true)
    childViewControllers.increase()
  }
  
  deinit {
    print("해제됨: Profile Coordinator")
  }
}

extension OnboardingProfileCoordinator: OnboardingProfileDelegate {
  public func pushToNextView(_ state: ProfileType) {
    let state: ProfileType = state.nextViewType
    
    let profileState = OnboardingProfileReactor.State(state: state)
    let onboardingProfileReator = OnboardingProfileReactor(profileState)
    let onboardingProfileController = OnboardingProfileController(reactor: onboardingProfileReator)
    
    onboardingProfileController.delegate = self
    navigationController.pushViewController(onboardingProfileController, animated: true)
    childViewControllers.increase()
  }
  
  public func presentImageGuideModal() {
    let onboardingImageGuideContoller = OnboardingImageGuideController(reactor: OnboardingImageGuideReactor())

    onboardingImageGuideContoller.modalPresentationStyle = .pageSheet
    onboardingImageGuideContoller.delegate = self
    navigationController.present(onboardingImageGuideContoller, animated: true)
  }
  
  public func switchToMainTab() {
    print("profile - nil")
  }
}

extension OnboardingProfileCoordinator: OnboardingImageGuideDelegate, PHPickerViewControllerDelegate {
  public func pushToImagePicker() {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 1
    configuration.filter = .any(of: [.images])
    
    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = self
    
    navigationController.present(picker, animated: true)
  }
    
  public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    
    let itemProvider = results.first?.itemProvider
    
    if let itemProvider = itemProvider,
       itemProvider.canLoadObject(ofClass: UIImage.self) {
      itemProvider.loadObject(ofClass: UIImage.self) { image, error in
        if let image = image as? UIImage {
          DispatchQueue.main.async {
            if let vc = self.navigationController.viewControllers.last as? OnboardingProfileController {
              vc.reactor?.action.onNext(.selectImage(image))
            }
          }
        }
      }
    }
  }
}
