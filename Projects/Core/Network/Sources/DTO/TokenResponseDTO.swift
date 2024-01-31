//
//  TokenResponseDTO.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import DomainCommonInterface

public struct TokenResponseDTO: Decodable {
  public let accessToken: String
  public let refreshToken: String
  
  public func toDomain() -> Token {
    return Token(
      accessToken: self.accessToken,
      refreshToken: self.refreshToken
    )
  }
}
