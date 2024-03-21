//
//  ProfileMainReactor.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/17/24.
//

import ReactorKit
import DomainUser

final class ProfileMainReactor: Reactor {
  
  enum Action {
  }
  
  enum Mutation {
  }
  
  struct State {
    var profileData: UserData = UserData(nickname: "jiho", mobileNumber: "01077777777", birth: "2000-11-14", gender: "MAIL", mbti: "INTP", authority: "authority", address: nil, imageData: nil, interests: [], job: nil, introduce: nil, blueCheck: false)
    var candyCount: Int = 10
    var ticketCount: Int = 10
  }
  
  var inputFinishPercent: Double {
    let fullCount: Double = 13
    var emptyCount: Double = 0
    if self.currentState.profileData.mbti == nil {
      emptyCount += 1
    }
    if self.currentState.profileData.authority == nil {
      emptyCount += 1
    }
    if self.currentState.profileData.address == nil {
      emptyCount += 1
    }
    if self.currentState.profileData.imageData == nil {
      emptyCount += 1
    }
    if self.currentState.profileData.interests.count < 3 {
      emptyCount += 1
    }
    if self.currentState.profileData.job == nil {
      emptyCount += 1
    }
    if self.currentState.profileData.introduce == nil {
      emptyCount += 1
    }
    return 100 / fullCount * (fullCount - emptyCount)
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
