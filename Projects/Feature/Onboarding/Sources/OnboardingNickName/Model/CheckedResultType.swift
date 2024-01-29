//
//  CheckStateType.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/5/24.
//

import Foundation

public enum CheckedResultType {
  case outOfRange
  case duplication
  case none

  public var description: String {
    switch self {
    case .outOfRange:
      "닉네임은 10자 이내로 만들어주세요."
    case .duplication:
      "누군가 이미 쓰고 있어요. 다른 닉네임을 입력해주세요."
    case .none:
      ""
    }
  }
}
