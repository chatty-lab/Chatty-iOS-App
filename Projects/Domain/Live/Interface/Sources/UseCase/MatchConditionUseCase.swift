//
//  GetMatchConditionUseCase.swift
//  DomainLiveInterface
//
//  Created by 윤지호 on 3/17/24.
//

import Foundation
import RxSwift

public protocol MatchConditionUseCase {
  func saveCondition(state: MatchConditionState) -> MatchConditionState
  func getCondition() -> MatchConditionState
}
