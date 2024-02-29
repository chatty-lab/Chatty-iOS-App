//
//  LiveCoordinator.swift
//  FeatureLive
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared
import SharedDesignSystem

public final class LiveMainCoordinator: BaseCoordinator {
  public override var type: CoordinatorType {
    .live(.main)
  }
  
//  private let dependencyProvider: FeatureOnboardingDependencyProvider
  
  public override init(navigationController: CustomNavigationController) {
    super.init(navigationController: navigationController)
  }
  
  deinit {
    print("해제됨: LiveMainCoordinator")
  }
  
  public override func start() {
    let reactor = LiveMainReactor()
    let liveController = LiveMainController(reactor: reactor)
    liveController.delegate = self
    childViewControllers.increase()
    navigationController.pushViewController(liveController, animated: false)
  }
}

extension LiveMainCoordinator: LiveMainControllerDelegate {
  func pushToMatchingView() {
    print("push - MatchingView")
  }
  
  func pushToCandyStore() {
    print("push - CandyStore")
  }
  
  func pushToMembershipView() {
    print("push - MembershipView")
  }
  
  func presentEditGenderConditionModal(_ gender: MatchGender) {
    let editGenderConditionModal = LiveEditGenderConditionModal(reactor: .init(gender: gender))
    editGenderConditionModal.modalPresentationStyle = .pageSheet
    editGenderConditionModal.delegate = self
    navigationController.present(editGenderConditionModal, animated: true)
  }
  
  func presentEditAgeConditionModal() {
    print("present - AgeConditionModal")
  }
}

extension LiveMainCoordinator: LiveEditGenderConditionModalDelegate {
  public func dismiss() {
    DispatchQueue.main.async {
      self.navigationController.dismiss(animated: true)
    }
  }
  
  public func editFinished(_ selectedGender: MatchGender) {
    DispatchQueue.main.async {
      if let vc = self.navigationController.viewControllers.last as? LiveMainController {
        vc.reactor?.action.onNext(.selectGender(selectedGender))
      }
      self.navigationController.dismiss(animated: true)
    }
  }
  
  
}
