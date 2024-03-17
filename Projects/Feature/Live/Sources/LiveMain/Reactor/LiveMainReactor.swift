//
//  LiveMainReactor.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/28/24.
//

import ReactorKit
import DomainLiveInterface

final class LiveMainReactor: Reactor {
  private let matchConditionUseCase: MatchConditionUseCase
  
  enum Action {
    case viewWillAppear
  }
  
  enum Mutation {
    case setMatchConditionState(MatchConditionState)
  }
  
  struct State {
    var matchState: MatchConditionState = MatchConditionState()
    var matchMode: MatchMode = .nomalMode
  }
  
  var initialState: State = State()
  
  public init(matchConditionUseCase: MatchConditionUseCase) {
    self.matchConditionUseCase = matchConditionUseCase
  }
} 

extension LiveMainReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewWillAppear:
      let state = matchConditionUseCase.getCondition()
      return .just(.setMatchConditionState(state))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setMatchConditionState(let matchConditionState):
      newState.matchState.gender = matchConditionState.gender
    }
    return newState
  }
}
