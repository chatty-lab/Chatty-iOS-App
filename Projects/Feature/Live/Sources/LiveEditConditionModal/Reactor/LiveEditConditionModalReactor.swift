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
    var gender: MatchGender = .all
    var age: Int = 20
  }
  
  public var initialState: State
  
  init(gender: MatchGender = .all, age: Int = 20) {
    self.initialState = State(gender: gender, age: age)
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
      newState.gender = matchGender
    case .setAgeCondition(let int):
      newState.age = int
    }
    return newState
  }
}
