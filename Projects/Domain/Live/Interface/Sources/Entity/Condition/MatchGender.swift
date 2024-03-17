//
//  MatchGender.swift
//  DomainLiveInterface
//
//  Created by 윤지호 on 3/17/24.
//

import Foundation

public enum MatchGender: Codable {
  case male
  case female
  case all
  
  public var requestString: String {
    switch self {
    case .male:
      return "MALE"
    case .female:
      return "FEMALE"
    case .all:
      return "ALL"
    }
  }
  
  public var text: String {
    switch self {
    case .male:
      return "남자"
    case .female:
      return "여자"
    case .all:
      return "모두"
    }
  }
}
