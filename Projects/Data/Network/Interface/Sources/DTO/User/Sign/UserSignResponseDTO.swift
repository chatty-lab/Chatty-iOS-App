//
//  UserAuthResponseDTO.swift
//  DataNetworkInterface
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import DomainAuth

public struct UserSignResponseDTO: CommonResponseDTO {
  public var code: Int
  public var status: String
  public var message: String
  public var data: TokenResponseDTO
  
  public func toDomain() -> Token {
    return data.toDomain()
  }
}
