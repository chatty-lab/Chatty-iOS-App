//
//  UserDataResponseDTO.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import DomainUser

public struct UserDataReponseDTO: Decodable {
  public let id: Int
  public let mobileNumber: String
  public let nickname: String
  public let birth: String
  public let gender: String
  public let mbti: String
  public let authority: String
  public let address: String?
  public let interests: [String]?
  public let imageUrl: String?
  public let school: String?
  public let job: String?
  public let introduce: String
  public let blueCheck: Bool
  
  public func toDomain() -> UserData {
    return UserData(
      nickname: self.nickname,
      mobileNumber: self.mobileNumber,
      birth: self.birth,
      gender: self.gender,
      mbti: self.mbti,
      authority: self.authority,
      address: self.address,
      imageUrl: self.imageUrl,
      interests: self.interests,
      job: self.job,
      introduce: self.introduce,
      school: self.school,
      blueCheck: self.blueCheck)
  }
}
