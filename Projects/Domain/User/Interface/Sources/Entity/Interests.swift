//
//  Interests.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 3/7/24.
//

import Foundation

public struct Interests {
  public let interests: [Interest]
  
  public init(interests: [Interest]) {
    self.interests = interests
  }
}

public struct Interest: Equatable {
  public let id: Int
  public let name: String
  
  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
  }
}
