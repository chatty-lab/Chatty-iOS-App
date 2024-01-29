//
//  UserDataResponseDTO.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation

public struct UserDataReponseDTO: Decodable {
  public let id: Int
  public let mobileNumber: String
  public let nickname: String
  public let birth: String
  public let gender: String
  public let mbti: String
  public let address: String?
  public let authority: String
  public let imageUrl: String
}
