//
//  AccountOwnerCheckCoordinator.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 1/30/24.
//

import UIKit
import Shared
import SharedDesignSystem

public protocol AccountOwnerCheckDelegate: AnyObject {
  func pushToQuestion(step: AccountSecurityQuestionType)
  func pushToCompleted()
  func pushToFailed(type: AccountAccessFailedType)
  func pushToCreateAccount()
}

public final class AccountOwnerCheckCoordinator: BaseCoordinator {
  public override var type: CoordinatorType {
   return .onboarding(.newDeviceAccess(.accountOwnerCheck))
  }
  
  public override func start() {
    let onboardingAccountOwnerCheckController = OnboardingAccountOwnerCheckController()
    onboardingAccountOwnerCheckController.delegate = self
    navigationController.pushViewController(onboardingAccountOwnerCheckController, animated: true)
    childViewControllers.increase()
  }
}

extension AccountOwnerCheckCoordinator: AccountOwnerCheckDelegate {
  public func pushToQuestion(step: AccountSecurityQuestionType) {
    let accountSecurityQuestionController = AccountSecurityQuestionController(reactor: .init(), step: step)
    accountSecurityQuestionController.delegate = self
    navigationController.pushViewController(accountSecurityQuestionController, animated: true)
    childViewControllers.increase()
  }
  
  public func pushToCompleted() {
    let accountAccessCompletedController = AccountAccessCompletedController()
    navigationController.setViewControllers([accountAccessCompletedController], animated: true)
    childViewControllers.increase()
  }
  
  public func pushToFailed(type: AccountAccessFailedType) {
    let accountAccessFailedController = AccountAccessFailedController(failedType: type)
    navigationController.pushViewController(accountAccessFailedController, animated: true)
    childViewControllers.increase()
  }
  
  public func pushToCreateAccount() {
    
  }
}
