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
import FeatureOnboardingInterface

public final class OnboardingProfileCoordinator: BaseCoordinator {
  public override var type: CoordinatorType {
    .onboarding(.profileUpdate(.profiles))
  }
  
  private let dependencyProvider: FeatureOnboardingDependencyProvider
  
  init(navigationController: CustomNavigationController, dependencyProvider: FeatureOnboardingDependencyProvider) {
    self.dependencyProvider = dependencyProvider
    super.init(navigationController: navigationController)
  }
  
  public override func start() {
    let onboardingProfileReactor = OnboardingProfileReactor(
      saveProfileDataUseCase: dependencyProvider.makeSaveProfileDataUseCase(),
      getUserDataUseCase: dependencyProvider.makeGetProfileDataUseCase(),
      profileType: .gender
    )
    let onboardingProfileController = OnboardingProfileController(reactor: onboardingProfileReactor)
    onboardingProfileController.delegate = self
    navigationController.pushViewController(onboardingProfileController, animated: true)
  }
  
  deinit {
    print("해제됨: Profile Coordinator")
  }
}

extension OnboardingProfileCoordinator: OnboardingProfileDelegate {
  public func pushToNextView(_ state: ProfileType) {
    let profileType: ProfileType = state.nextViewType
    
    let onboardingProfileReator = OnboardingProfileReactor(
      saveProfileDataUseCase: dependencyProvider.makeSaveProfileDataUseCase(),
      getUserDataUseCase: dependencyProvider.makeGetProfileDataUseCase(),
      profileType: profileType
    )
    let onboardingProfileController = OnboardingProfileController(reactor: onboardingProfileReator)
    
    onboardingProfileController.delegate = self
    
    navigationController.pushViewController(onboardingProfileController, animated: true)
  }
  
  public func presentImageGuideModal() {
    let onboardingImageGuideContoller = OnboardingImageGuideController(reactor: OnboardingImageGuideReactor())

    onboardingImageGuideContoller.modalPresentationStyle = .pageSheet
    onboardingImageGuideContoller.delegate = self
    
    navigationController.present(onboardingImageGuideContoller, animated: true)
  }
  
  public func switchToMainTab() {
    appFlowControl.delegete?.showMainFlow()
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
