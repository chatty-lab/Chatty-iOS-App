//
//  RefreshRequestDTO.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation

public struct RefreshRequestDTO: Encodable {
  let refreshToken: String
  
  public init(refreshToken: String) {
    self.refreshToken = refreshToken
  }
}
