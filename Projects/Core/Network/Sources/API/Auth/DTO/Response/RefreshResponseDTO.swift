//
//  RefreshResponseDTO.swift
//  CoreNetworkInterface
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation

public struct RefreshResponseDTO: CommonResponseDTO {
  public var code: Int
  public var status: String
  public var message: String
  public var data: TokenResponseDTO
}
