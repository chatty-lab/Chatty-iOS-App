//
//  UserUpdateRequestDTO.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation

public struct UserUpdateRequestDTO: Encodable {
  let coordinate: Coordinate
  let nickname: String
  let gender: String
  let birth: String
  let mbti: String
  
  struct Coordinate: Encodable {
    let lat: Double
    let lng: Double
  }
}
