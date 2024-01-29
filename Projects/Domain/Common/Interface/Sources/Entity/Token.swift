//
//  Entity.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation

public struct Token {
  public let accessToken: String
  public let refreshToken: String
  
  public init(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
