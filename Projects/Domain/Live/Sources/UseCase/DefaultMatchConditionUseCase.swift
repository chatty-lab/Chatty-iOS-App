//
//  DefaultMatchConditionUseCase.swift
//  DomainLiveInterface
//
//  Created by 윤지호 on 3/17/24.
//

import Foundation
import DomainLiveInterface
import DomainCommon

import RxSwift

public final class DefaultMatchConditionUseCase: MatchConditionUseCase {
  private let userDefaultsRepository: UserDefaultsRepositoryProtocol
  
  public init(userDefaultsRepository: UserDefaultsRepositoryProtocol) {
    self.userDefaultsRepository = userDefaultsRepository
  }
  
  public func saveCondition(state: MatchConditionState) -> MatchConditionState {
    do {
      let data = try JSONEncoder().encode(state)
      userDefaultsRepository.requestCreate(type: .matchConditionState(data))
      return getCondition()
    } catch {
      return getCondition()
    }
  }
  
  public func getCondition() -> MatchConditionState {
    let condition: Data? = userDefaultsRepository.requestRead(type: .matchConditionState())
    
    guard let condition else {
      return saveCondition(state: MatchConditionState(gender: .all, ageRange: .init(startAge: 20, endAge: 40), isProfileAuthenticationConnection: false))
    }
    
    do {
      let decodedData = try JSONDecoder().decode(MatchConditionState.self, from: condition)
      return decodedData
    } catch {
      return MatchConditionState(gender: .all, ageRange: .init(startAge: 20, endAge: 40), isProfileAuthenticationConnection: false)
    }
  }
}
