//
//  ProfileMainReactor.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/17/24.
//

import ReactorKit

final class ProfileMainReactor: Reactor {
  
  enum Action {
  }
  
  enum Mutation {
  }
  
  struct State {
   
  }
  
  var initialState: State = State()
  
  public init() { }
}

extension ProfileMainReactor {
//  func mutate(action: Action) -> Observable<Mutation> {
//    return
//  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    return newState
  }
}
