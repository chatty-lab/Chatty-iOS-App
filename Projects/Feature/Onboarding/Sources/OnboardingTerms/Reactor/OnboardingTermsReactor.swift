//
//  OnboardingTermsReactor.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/28/23.
//

import Foundation
import RxSwift
import ReactorKit

final class OnboardingTermsReactor: Reactor {
  /// 온보딩 약관 화면에서 수행할 수 있는 사용자의 액션을 정의해요
  enum Action {
    case toggleAccept(Terms)
    case toggleAcceptAll
  }
  
  /// 화면의 상태를 변화하는 요인을 정의해요
  enum Mutation {
    case setAccept(Terms)
    case setAcceptAll(Bool)
    case enableSignUpButton(Bool)
  }
  
  /// 현재 온보딩 약관 화면의 상태를 나타내는 구조체에요
  struct State {
    var termsOfService: Terms
    var privacyPolicy: Terms
    var locationDataUsage: Terms
    var isAllAccepted: Bool = false
    var isSignUpButtonEnabled: Bool = false
    
    init() {
      termsOfService = Terms(type: .termsOfService, isRequired: true, isAccepted: false)
      privacyPolicy = Terms(type: .privacyPolicy, isRequired: true, isAccepted: false)
      locationDataUsage = Terms(type: .locationDataUsage, isRequired: false, isAccepted: false)
    }
  }
  
  let initialState: State = State()
}

extension OnboardingTermsReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .toggleAccept(let terms):
      var newTerms = terms
      newTerms.isAccepted.toggle()
      return .just(.setAccept(newTerms))
    case .toggleAcceptAll:
      return .just(.setAcceptAll(!currentState.isAllAccepted))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setAccept(let terms):
      switch terms.type {
      case .termsOfService:
        newState.termsOfService = terms
      case .privacyPolicy:
        newState.privacyPolicy = terms
      case .locationDataUsage:
        newState.locationDataUsage = terms
      }
      let isAllAccepted = newState.termsOfService.isAccepted &&
                         newState.privacyPolicy.isAccepted &&
                         newState.locationDataUsage.isAccepted
      newState.isAllAccepted = isAllAccepted
      
      let requiredTermsAccepted = newState.termsOfService.isAccepted &&
                              newState.privacyPolicy.isAccepted
      newState.isSignUpButtonEnabled = requiredTermsAccepted
    case .setAcceptAll(let isAllAccepted):
      newState.termsOfService.isAccepted = isAllAccepted
      newState.privacyPolicy.isAccepted = isAllAccepted
      newState.locationDataUsage.isAccepted = isAllAccepted
      newState.isAllAccepted = isAllAccepted
      newState.isSignUpButtonEnabled = isAllAccepted
    case .enableSignUpButton(let bool):
      newState.isSignUpButtonEnabled = bool
    }
    return newState
  }
}
