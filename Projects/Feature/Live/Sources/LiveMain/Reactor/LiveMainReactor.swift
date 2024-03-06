//
//  LiveMainReactor.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/28/24.
//

import ReactorKit

final class LiveMainReactor: Reactor {
  
  enum Action {
    case selectGender(MatchGender)
  }
  
  enum Mutation {
    case setGender(MatchGender)
  }
  
  struct State {
    var matchState: MatchConditionState = MatchConditionState()
  }
  
  var initialState: State = State()
  
}

extension LiveMainReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .selectGender(let matchGender):
      return .just(.setGender(matchGender))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setGender(let matchGender):
      newState.matchState.gender = matchGender
    }
    return newState
  }
}
