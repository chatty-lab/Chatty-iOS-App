//
//  RefreshResponseDTO.swift
//  CoreNetworkInterface
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import DomainCommonInterface

public struct RefreshResponseDTO: CommonResponseDTO {
  public var code: Int
  public var status: String
  public var message: String
  public var data: TokenResponseDTO
  
  public func toDomain() -> Token {
    return data.toDomain()
  }
}
