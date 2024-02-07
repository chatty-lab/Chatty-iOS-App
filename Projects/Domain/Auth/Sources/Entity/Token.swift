//
//  Token.swift
//  DomainAuth
//
//  Created by HUNHIE LEE on 2/3/24.
//

import Foundation
import DomainCommon

public struct Token: TokenProtocol {
  public let accessToken: String
  public let refreshToken: String
  
  public init(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
