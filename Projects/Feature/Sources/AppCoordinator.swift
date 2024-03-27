//
//  AppCoordinator.swift
//  Feature
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit
import Shared
import SharedDesignSystem
import FeatureOnboarding
import RxSwift
import RxBlocking

public final class AppCoordinator: BaseCoordinator, AppFlowDelegate {
  public override var type: CoordinatorType {
    return .app
  }
  
  public var window: UIWindow
  
  private let featureDependencyProvider: AppDependencyProvider
  
  private let disposeBag = DisposeBag()
  
  public init(window: UIWindow, navigationController: CustomNavigationController, featureDependencyProvider: AppDependencyProvider) {
    self.window = window
    self.featureDependencyProvider = featureDependencyProvider
    super.init(navigationController: navigationController)
    self.appFlowControl.delegete = self
  }
  
  public override func start() {
    let validateAccessTokenUseCase = featureDependencyProvider.makeValiateAccessTokenUseCase()
    let getProfileDataUseCase = featureDependencyProvider.makeGetProfileUseCase()
    
    do {
      let isValid = try validateAccessTokenUseCase.execute().toBlocking().single()
      let profile = try getProfileDataUseCase.execute(hasFetched: true).toBlocking().single()
      
      if isValid {
        if profile.authority == .anonymous {
          self.showOnboardingFlow()
        }
        if profile.authority == .user {
          self.showMainFlow()
        }
      } else {
        // 유효성 검사 실패 처리
        print("자동 로그인 실패! 온보딩으로~")
        self.showOnboardingFlow()
      }
    } catch {
      print("에러 처리: \(error)")
      self.showOnboardingFlow()
    }
  }
  
  public func showOnboardingFlow() {
    let onboardingCoordinator = OnboardingRootCoordinator(
      navigationController: navigationController,
      dependencyProvider: featureDependencyProvider.makeFeatureOnboardingDependencyProvider()
    )
    
    childCoordinators.append(onboardingCoordinator)
    onboardingCoordinator.start()
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  public func showOnboardingProfileFlow() {
    let onboardingNicknameCoordinator = OnboardingNickNameCoordinator(navigationController: navigationController, dependencyProvider: featureDependencyProvider.makeFeatureOnboardingDependencyProvider())
    onboardingNicknameCoordinator.start()
    
    childCoordinators.removeAll()
    childCoordinators.append(onboardingNicknameCoordinator)
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  public func showMainFlow() {
    navigationController.setCustomNavigationBarHidden(true, animated: false)
    let mainCoordinator = MainTabBarCoordinator(navigationController, featureChatDependencyProvider: featureDependencyProvider.makeFeatureChatDependencyProvider())
    mainCoordinator.start()
    
    childCoordinators.removeAll()
    childCoordinators.append(mainCoordinator)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}
