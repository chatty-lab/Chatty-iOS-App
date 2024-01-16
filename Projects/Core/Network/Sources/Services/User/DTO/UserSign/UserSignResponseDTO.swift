//
//  UserSignResponseDTO.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation

public struct UserSignResponseDTO: CommonResponseDTO {
  public let code: Int
  public let status: String
  public let message: String
  public let data: Data
  
  public struct Data: Decodable {
    let accessToken: String
    let refreshToken: String
  }
}
