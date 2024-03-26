//
//  MatchConditionState.swift
//  DomainLiveInterface
//
//  Created by 윤지호 on 3/17/24.
//

import Foundation

public struct MatchConditionState: Codable {
  public var gender: MatchGender = .all
  public var ageRange: MatchAgeRange = .init(startAge: 20, endAge: 40)
  
  public var isProfileAuthenticationConnection: Bool = false
  
  public init() {
    self.gender = .all
    self.ageRange = .init(startAge: 20, endAge: 40)
    self.isProfileAuthenticationConnection = false
  }
  
  public init(gender: MatchGender, ageRange: MatchAgeRange, isProfileAuthenticationConnection: Bool) {
    self.gender = gender
    self.ageRange = ageRange
    self.isProfileAuthenticationConnection = isProfileAuthenticationConnection
  }
}
