//
//  FeatureLiveDIcontainer.swift
//  Chatty
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import FeatureLiveInterface
import DomainLive

final class FeatureLiveDIcontainer: RepositoryDIcontainer, FeatureLiveDependencyProvider {
  func makeConnectMatchUseCase() -> DefaultConnectMatchUseCase {
    return DefaultConnectMatchUseCase(
      liveAPIRepository: makeLiveAPIRepository(),
      liveSocketRepository: makeLiveSocketRepository()
    )
  }
  
  func makeMatchConditionUseCase() -> DefaultMatchConditionUseCase {
    return DefaultMatchConditionUseCase(
      userDefaultsRepository: makeUserDefaultsRepository()
    )
  }
}
