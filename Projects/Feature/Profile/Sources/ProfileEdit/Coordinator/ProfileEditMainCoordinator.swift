//
//  ProfileEditMainCoordinator.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/21/24.
//

import Foundation
import Shared
import SharedDesignSystem
import FeatureProfileInterface

public final class ProfileEditMainCoordinator: BaseCoordinator, ProfileEditMainCoordinatorProtocol {
  public override var type: CoordinatorType {
    .profile(.editMain)
  }
  
  private let featureProfileDependencyProvider: FeatureProfileDependencyProvider

  public init(navigationController: CustomNavigationController, featureProfileDependencyProvider: FeatureProfileDependencyProvider) {
    self.featureProfileDependencyProvider = featureProfileDependencyProvider
    super.init(navigationController: navigationController)
  }
  
  deinit {
    print("해제됨: ProfileEditMainCoordinator")
  }
  
  public override func start() {
    let reactor = ProfileEditMainReactor(getUserDataUseCase: featureProfileDependencyProvider.makeGetProfileDataUseCase())
    let profileEditMainController = ProfileEditMainController(reactor: reactor)
    navigationController.pushViewController(profileEditMainController, animated: true)
  }
}
