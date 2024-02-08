//
//  AccountSecurityQuestionReactor.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 1/31/24.
//

import UIKit
import RxSwift
import ReactorKit
import SharedDesignSystem

public final class AccountSecurityQuestionReactor: Reactor {
  public enum Action {
    case getQuestion(AccountSecurityQuestionType)
    case answerSelected(AccountSecurityAnswerType)
    case answerEntered
  }
  
  public enum Mutation {
    case setQuestion(AccountSecurityQuestionType)
    case setAnswer(AccountSecurityAnswerType)
    case setContinueButton(Bool)
    case answerEnter
  }
  
  public struct State {
    var nickname: [RadioSegmentItem] = []
    var birth: [RadioSegmentItem] = []
    var answer: AccountSecurityAnswerType?
    var isCorrect: AnswerStatus? = nil
    var isContinueButtonEnabled: Bool = false
  }
  
  public let initialState: State = State()
  
  public init() { }
}

extension AccountSecurityQuestionReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .answerEntered:
      return .just(.answerEnter)
    case .answerSelected(let answer):
      return .from(
        [
          .setContinueButton(true),
          .setAnswer(answer)
        ]
      )
    case .getQuestion(let type):
      return .just(.setQuestion(type))
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .answerEnter:
      if newState.answer == .answer1 {
        newState.isCorrect = .correct
      } else {
        newState.isCorrect = .incorrect(Int.random(in: 1...2))
      }
    case .setContinueButton(let bool):
      newState.isContinueButtonEnabled = bool
    case .setAnswer(let answer):
      newState.answer = answer
    case .setQuestion(let type):
      switch type {
      case .nickname:
        newState.nickname = [
          RadioSegmentItem(id: 0, title: "시락이"),
          RadioSegmentItem(id: 1, title: "옴팡이지롱"),
          RadioSegmentItem(id: 2, title: "윤둥똥차"),
          RadioSegmentItem(id: 3, title: "오엔제이"),
          RadioSegmentItem(id: 4, title: "감쇠진동"),
        ]
      case .birth:
        newState.birth = [
          RadioSegmentItem(id: 0, title: "1987"),
          RadioSegmentItem(id: 1, title: "1992"),
          RadioSegmentItem(id: 2, title: "1997"),
          RadioSegmentItem(id: 3, title: "1995"),
          RadioSegmentItem(id: 4, title: "1998"),
        ]
      }
    }
    return newState
  }
  
  enum AnswerStatus: Equatable {
    case correct
    case incorrect(Int)
  }
}
