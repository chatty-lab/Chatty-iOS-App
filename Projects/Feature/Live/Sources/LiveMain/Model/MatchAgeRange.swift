//
//  MatchAgeRange.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import Foundation

public struct MatchAgeRange {
  var startAge: Int
  var endAge: Int
  
  /// "20 - 30"
  var toHyphen: String {
    return "\(startAge) - \(endAge)"
  }
  
  /// "20~30세"
  var toTilde: String {
    return "\(startAge)~\(endAge)"
  }
}
