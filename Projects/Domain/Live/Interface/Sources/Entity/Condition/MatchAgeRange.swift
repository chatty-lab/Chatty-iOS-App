//
//  MatchAgeRange.swift
//  DomainLiveInterface
//
//  Created by 윤지호 on 3/17/24.
//

import Foundation

public struct MatchAgeRange: Codable {
  public var startAge: Int
  public var endAge: Int
  
  public init(startAge: Int, endAge: Int) {
    self.startAge = startAge
    self.endAge = endAge
  }
  
  /// "20 - 30"
  public var toHyphen: String {
    return "\(startAge) - \(endAge)"
  }
  
  /// "20~30세"
  public var toTilde: String {
    return "\(startAge)~\(endAge)"
  }
}
