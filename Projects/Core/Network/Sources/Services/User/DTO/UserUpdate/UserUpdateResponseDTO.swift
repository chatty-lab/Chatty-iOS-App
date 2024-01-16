//
//  UserUpdateResponseDTO.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation

public struct UserUpdateResponseDTO: CommonResponseDTO {
  public let code: Int
  public let status: String
  public let message: String
  public let data: Data
  
  public struct Data: Decodable {
    let id: Int
    let mobileNumber: String
    let nickname: String
    let birth: String
    let gender: String
    let mbti: String
    let address: String
    let authority: String
    let imageUrl: String
    let coordinate: Coordinate
    
    struct Coordinate: Decodable {
      let lat: Double
      let lng: Double
    }
  }
}
