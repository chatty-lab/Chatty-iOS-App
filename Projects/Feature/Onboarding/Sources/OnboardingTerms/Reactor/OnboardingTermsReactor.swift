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
    case toggleConsent(Terms)
    case toggleAllConsent
  }
  
  /// 화면의 상태를 변화하는 요인을 정의해요
  enum Mutation {
    case setConsent(Terms)
    case setAllConsent(Bool)
    case enableAdvanceButton(Bool)
  }
  
  /// 현재 온보딩 약관 화면의 상태를 나타내는 구조체에요
  struct State {
    var termsOfService: Terms
    var privacyPolicy: Terms
    var locationDataUsage: Terms
    var isAllConsented: Bool = false
    var isAdvanceButtonEnabled: Bool = false
    
    init() {
      termsOfService = Terms(type: .termsOfService, isRequired: true, isConsented: false)
      privacyPolicy = Terms(type: .privacyPolicy, isRequired: true, isConsented: false)
      locationDataUsage = Terms(type: .locationDataUsage, isRequired: false, isConsented: false)
    }
  }
  
  let initialState: State = State()
}

extension OnboardingTermsReactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .toggleConsent(let terms):
      var newTerms = terms
      newTerms.isConsented.toggle()
      return .just(.setConsent(newTerms))
    case .toggleAllConsent:
      return .just(.setAllConsent(!currentState.isAllConsented))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setConsent(let terms):
      switch terms.type {
      case .termsOfService:
        newState.termsOfService = terms
      case .privacyPolicy:
        newState.privacyPolicy = terms
      case .locationDataUsage:
        newState.locationDataUsage = terms
      }
      let allConsented = newState.termsOfService.isConsented &&
                         newState.privacyPolicy.isConsented &&
                         newState.locationDataUsage.isConsented
      newState.isAllConsented = allConsented
      
      let requiredConsented = newState.termsOfService.isConsented &&
                              newState.privacyPolicy.isConsented
      newState.isAdvanceButtonEnabled = requiredConsented
    case .setAllConsent(let isAllConsented):
      newState.termsOfService.isConsented = isAllConsented
      newState.privacyPolicy.isConsented = isAllConsented
      newState.locationDataUsage.isConsented = isAllConsented
      newState.isAllConsented = isAllConsented
      newState.isAdvanceButtonEnabled = isAllConsented
    case .enableAdvanceButton(let bool):
      newState.isAdvanceButtonEnabled = bool
    }
    return newState
  }
}
