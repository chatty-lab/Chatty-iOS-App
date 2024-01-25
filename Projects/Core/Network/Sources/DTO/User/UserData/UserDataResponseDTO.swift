//
//  UserDataResponseDTO.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation

public struct UserDataReponseDTO: Decodable {
  let id: Int
  let mobileNumber: String
  let nickname: String
  let birth: String
  let gender: String
  let mbti: String
  let address: String
  let authority: String
  let imageUrl: String
}
