//
//  Gender.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/8/24.
//

import Foundation

public enum Gender {
  case male
  case female
  case none
  
  var string: String {
    switch self {
    case .male:
      return "남성"
    case .female:
      return "여성"
    case .none:
      return ""
    }
  }
}
