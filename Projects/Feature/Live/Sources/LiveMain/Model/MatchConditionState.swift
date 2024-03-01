//
//  MatchState.swift
//  FeatureLive
//
//  Created by 윤지호 on 3/1/24.
//

import Foundation

public struct MatchConditionState {
  var gender: MatchGender = .all
  var ageRange: MatchAgeRange = .init(startAge: 20, endAge: 40)
  
  var isProfileAuthenticationConnection: Bool = false
  var matchMode: MatchMode = .nomalMode
}
