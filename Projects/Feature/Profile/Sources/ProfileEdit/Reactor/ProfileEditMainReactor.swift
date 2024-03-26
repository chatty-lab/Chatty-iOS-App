//
//  ProfileEditMainReactor.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/21/24.
//

import ReactorKit
import DomainUser
import DomainUserInterface
import DomainCommon

final class ProfileEditMainReactor: Reactor {
  private let getUserDataUseCase: GetUserDataUseCase
  
  enum Action {
    case changePage(Int)
  }
  
  enum Mutation {
    case setPage(Int)
  }
  
  struct State {
    var profileData: UserData = UserData(nickname: "jiho", mobileNumber: "01077777777", birth: "2000-11-14", gender: "MAIL", mbti: "INTP", authority: "authority", address: nil, imageData: nil, interests: [], job: nil, introduce: nil, blueCheck: false)
    
    var pageIndex: Int = 0
  }
  
  
  var initialState: State
  
  public init(getUserDataUseCase: GetUserDataUseCase) {
    self.getUserDataUseCase = getUserDataUseCase
//    self.initialState = State()
    self.initialState = State(profileData: getUserDataUseCase.execute() as! UserData)
  }
}

extension ProfileEditMainReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .changePage(let index):
      return .just(.setPage(index))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setPage(let index):
      newState.pageIndex = index
    }
    return newState
  }
}
