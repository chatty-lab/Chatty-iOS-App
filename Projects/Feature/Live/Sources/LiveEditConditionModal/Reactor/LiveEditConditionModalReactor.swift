//
//  LiveEditConditionModalReactor.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

public final class LiveEditConditionModalReactor: Reactor {
  public enum Action {
    case selectGender(MatchGender)
    case selectAge(Int)
  }
  
  public enum Mutation {
    case setGenderCondition(MatchGender)
    case setAgeCondition(Int)
  }
  
  public struct State {
    var matchConditionState: MatchConditionState
    var matchingState: MatchingState = .ready
  }
  
  public var initialState: State
  
  init(matchState: MatchConditionState) {
    self.initialState = State(matchConditionState: matchState)
  }
}

extension LiveEditConditionModalReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .selectGender(let matchGender):
      return .just(.setGenderCondition(matchGender))
    case .selectAge(let int):
      return .just(.setAgeCondition(int))
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setGenderCondition(let matchGender):
      newState.matchConditionState.gender = matchGender
    case .setAgeCondition(let int):
      newState.matchConditionState.ageRange.startAge = int
    }
    return newState
  }
}
