//
//  TokenResponseDTO.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation

public struct TokenResponseDTO: Decodable {
  public let accessToken: String
  public let refreshToken: String
}
