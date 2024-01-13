//
//  OnboardingNickNameCoordinatorReactor.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit
import FeatureOnboardingInterface

public final class OnboardingNickNameReactor: Reactor {
  /// 뷰에서 수행할 수 있는 사용자의 액션
  public enum Action {
    case inputText(String)
    case tabContinueButton
    case didPushed
  }
  
  /// 화면의 상태가 변화하는 요인
  public enum Mutation {
    case inputedText(String)
    case checkDuplicate(String)
    case isLoading(Bool)
    case didPushed
  }
  
  /// 화면의 상태를 나타내는 구조체
  public struct State {
    var nickNameText: String
    var checkedResult: CheckedResultType = .none
    var isButtonEnabled: Bool = false
    var successSave: Bool = false
    var isLoading: Bool = false
    
    init() {
      nickNameText = ""
    }
  }
  
  public var initialState: State = State()
}

extension OnboardingNickNameReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .inputText(let string):
      return .just(.inputedText(string))
    case .tabContinueButton:
      return .concat([
        .just(.isLoading(true)),
        .just(.checkDuplicate(currentState.nickNameText)),
        .just(.isLoading(false))
      ])
    case .didPushed:
      return .just(.didPushed)
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .inputedText(let string):
      newState.nickNameText = string
      if string.count > 10 {
        newState.isButtonEnabled = false
        newState.checkedResult = .outOfRange
      } else if string.isEmpty {
        newState.isButtonEnabled = false
      } else {
        newState.checkedResult = .none
        newState.isButtonEnabled = true
      }
    case .checkDuplicate(let text):
      // Core.saveNinkName()
      let saveResult = saveNickName(text)
      if saveResult {
        newState.successSave = true
      } else {
        newState.checkedResult = .duplication
        newState.isButtonEnabled = false
      }
    case .isLoading(let bool):
      newState.isLoading = bool
    case .didPushed:
      newState.successSave = false
    }
    return newState
  }
  
  private func saveNickName(_ nickNameText: String) -> Bool {
    SampleUserService.setNickNameDate(currentState.nickNameText)
    return nickNameText == "1" ? false : true
  }
}
