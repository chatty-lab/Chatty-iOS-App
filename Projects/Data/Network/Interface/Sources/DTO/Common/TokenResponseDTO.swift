//
//  TokenResponseDTO.swift
//  DataNetworkInterface
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import DomainAuth

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
