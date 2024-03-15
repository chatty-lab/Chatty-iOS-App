//
//  LiveCoordinator.swift
//  FeatureLive
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import Shared
import SharedDesignSystem

import FeatureLiveInterface

public final class LiveMainCoordinator: BaseCoordinator {
  public override var type: CoordinatorType {
    .live(.main)
  }
  
  private let featureLiveDependencyProvider: FeatureLiveDependencyProvider
  
  public init(navigationController: CustomNavigationController, featureLiveDependencyProvider: FeatureLiveDependencyProvider
  ) {
    self.featureLiveDependencyProvider = featureLiveDependencyProvider
    super.init(navigationController: navigationController)
  }
  
  deinit {
    print("해제됨: LiveMainCoordinator")
  }
  
  public override func start() {
    let reactor = LiveMainReactor()
    let liveController = LiveMainController(reactor: reactor)
    liveController.delegate = self
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
  
  func presentEditGenderConditionModal(_ matchState: MatchConditionState) {
    let liveMatchingReactor = LiveEditConditionModalReactor(
      matchState: matchState,
      connectMatchUserCase: self.featureLiveDependencyProvider.makeConnectMatchUseCase()
    )
    let editGenderConditionModal = LiveEditGenderConditionModal(reactor: liveMatchingReactor)
    editGenderConditionModal.modalPresentationStyle = .pageSheet
    editGenderConditionModal.delegate = self
    navigationController.present(editGenderConditionModal, animated: true)
  }
  
  func presentEditAgeConditionModal(_ matchState: MatchConditionState) {
    let liveMatchingReactor = LiveEditConditionModalReactor(
      matchState: matchState,
      connectMatchUserCase: self.featureLiveDependencyProvider.makeConnectMatchUseCase()
    )
    let editAgeConditionModal = LiveEditAgeConditionModal(reactor: liveMatchingReactor)
    editAgeConditionModal.modalPresentationStyle = .pageSheet
    editAgeConditionModal.delegate = self
    navigationController.present(editAgeConditionModal, animated: true)
  }
  
  func presentMatchModeModal(_ matchState: MatchConditionState) {
    let liveMatchingReactor = LiveEditConditionModalReactor(
      matchState: matchState,
      connectMatchUserCase: self.featureLiveDependencyProvider.makeConnectMatchUseCase()
    )
    let matchModeModal = LiveMatchModeModal(reactor: liveMatchingReactor)
    matchModeModal.modalPresentationStyle = .pageSheet
    matchModeModal.delegate = self
    navigationController.present(matchModeModal, animated: true)
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

extension LiveMainCoordinator: LiveEditAgeConditionModalDelegate {
  public func editFinished(_ ageRange: MatchAgeRange) {
    DispatchQueue.main.async {
      self.navigationController.dismiss(animated: true)
    }
  }
}

extension LiveMainCoordinator: LiveMatchModeModalDelegate {
  public func startMatching(_ matchState: MatchConditionState) {
    DispatchQueue.main.async {
      self.navigationController.dismiss(animated: true)
      
      let liveMatchingReactor = LiveEditConditionModalReactor(
        matchState: matchState,
        connectMatchUserCase: self.featureLiveDependencyProvider.makeConnectMatchUseCase()
      )
      let liveMatchingController = LiveMatchingController(reactor: liveMatchingReactor)
      liveMatchingController.modalPresentationStyle = .overFullScreen
      liveMatchingController.delegate = self
      self.navigationController.present(liveMatchingController, animated: true)
    }
  }
}

extension LiveMainCoordinator: LiveMatchingDelegate {
  func successMatching() {
    print("successMatching - Matching")
    DispatchQueue.main.async {
      self.navigationController.dismiss(animated: true)
    }
  }
}
