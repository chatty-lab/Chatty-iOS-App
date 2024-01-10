//
//  MBTI.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/8/24.
//

import Foundation

public struct MBTI {
  var first: Bool? = nil
  var second: Bool? = nil
  var third: Bool? = nil
  var fourth: Bool? = nil
  
  mutating func setMBTI(mbti: MBTISeletedState, state: Bool) {
    switch mbti {
    case .first:
      self.first = state
    case .second:
      self.second = state
    case .third:
      self.third = state
    case .fourth:
      self.fourth = state
    }
  }
  
  var result: String {
    let firstStr = self.first ?? true ? "E" : "I"
    let secondStr = self.second ?? true ? "S" : "N"
    let thirdStr = self.third ?? true ? "T" : "F"
    let fourthStr = self.fourth ?? true ? "J" : "P"

    return firstStr + secondStr + thirdStr + fourthStr
  }
  
  var didSeletedAll: Bool {
    let selects = [first, second, third, fourth]
    for select in selects {
      if select == nil { return false }
    }
    return true
  }
}

public enum MBTISeletedState {
  case first
  case second
  case third
  case fourth
  
  public func getString(state: Bool) -> (String, String) {
    switch self {
    case .first:
      return state ? ("E", "외향적") : ("I", "내향적")
    case .second:
      return state ? ("S", "감각적") : ("N", "직관적")
    case .third:
      return state ? ("T", "사고형") : ("F", "감정형")
    case .fourth:
      return state ? ("J", "판단형") : ("P", "인식형")
    }
  }
}
