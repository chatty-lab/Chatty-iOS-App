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
  
  func presentEditGenderConditionModal() {
    print("present - GenderConditionModal")
  }
  
  func presentEditAgeConditionModal() {
    print("present - AgeConditionModal")
  }
}
