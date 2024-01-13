//
//  OnboardingProfileViewModel.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import RxSwift
import ReactorKit

public final class OnboardingProfileReactor: Reactor {
  /// 뷰에서 수행할 수 있는 사용자의 액션
  public enum Action {
    case viewWillAppear
    case toggleGender(Gender)
    case selectBirth(Date)
    case toggleMBTI(MBTISeletedState, Bool)
    case tabContinueButton
    case tabImagePicker
    case didPushed
  }
  
  /// 화면의 상태가 변화하는 요인
  public enum Mutation {
    case viewWillAppear
    case inputedGender(Gender)
    case inputedBirth(Date)
    case toggleMBTI(MBTISeletedState, Bool)
    case tabContinueButton
    case tabImagePicker
    case didPushed
    case isLoading(Bool)
  }
  
  /// 화면의 상태를 나타내는 구조체
  public struct State {
    var viewState: ProfileType
    var profileData: ProfileState
    var isContinueEnabled: Bool = false
    var isPickingImage: Bool = false
    var isSuccessSave: Bool = false
    var isLoading: Bool = false
    
    init(state: ProfileType) {
      self.viewState = state
      self.profileData = SampleUserService.fetchDate()
    }
  }
  public var initialState: State
  
  public init(_ state: State) {
    self.initialState = state
  }
}

extension OnboardingProfileReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewWillAppear:
      return .just(.viewWillAppear)
    case .toggleGender(let gender):
      return .just(.inputedGender(gender))
    case .selectBirth(let date):
      return .just(.inputedBirth(date))
    case .tabContinueButton:
      return .just(.tabContinueButton)
    case .tabImagePicker:
      return .just(.tabImagePicker)
    case .didPushed:
      return .just(.didPushed)
    case .toggleMBTI(let mbti, let state):
      return .concat([
        .just(.isLoading(true)),
        .just(.toggleMBTI(mbti, state)),
        .just(.isLoading(false))
      ])
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .viewWillAppear:
      /// viewWillAppear 시점에 입력된 Profile 데이터를 가져와요
      newState.profileData = SampleUserService.fetchDate()
    case .inputedGender(let gender):
      newState.profileData.gender = gender
      newState.isContinueEnabled = true
    case .inputedBirth(let date):
      newState.profileData.birth = date
      newState.isContinueEnabled = true
    case .tabImagePicker:
      newState.isPickingImage = true
    case .toggleMBTI(let mbti, let state):
      newState.profileData.mbti.setMBTI(mbti: mbti, state: state)
      newState.isContinueEnabled = newState.profileData.mbti.didSeletedAll
    case .didPushed:
      newState.isSuccessSave = false
      newState.isPickingImage = false
    case .isLoading(let bool):
      newState.isLoading = bool
    
    /// 저장 api 통신 혹은 다음뷰로 가는 코드
    case .tabContinueButton:
      switch currentState.viewState {
      case .gender, .birth, .profileImage, .none:
        SampleUserService.setDate(currentState.profileData)
        newState.isSuccessSave = true
      case .mbti:
        // Core.saveProfiles
        SampleUserService.setDate(currentState.profileData)
        newState.isSuccessSave = true
      }
    }
    return newState
  }
  
  private func saveProfiles() -> Bool {
    return true
  }
}
