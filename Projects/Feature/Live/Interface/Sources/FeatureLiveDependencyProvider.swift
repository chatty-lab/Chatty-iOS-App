// This is for Tuist

import DomainLive

public protocol FeatureLiveDependencyProvider {
  func makeConnectMatchUseCase() -> DefaultConnectMatchUseCase
  func makeMatchConditionUseCase() -> DefaultMatchConditionUseCase
}
