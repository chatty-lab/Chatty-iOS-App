//
//  UserDataResponseDTO.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import DomainUserInterface
import DomainUser

public struct UserDataReponseDTO: Decodable {
  let id: Int
  let mobileNumber: String
  let nickname: String
  let birth: String
  let gender: String
  let mbti: String
  let address: String?
  let authority: String
  let imageUrl: String?
  let interests: [String]
  let job: String?
  let introduce: String?
  let school: String?
  let blueCheck: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case mobileNumber
    case nickname
    case birth
    case gender
    case mbti
    case address
    case authority
    case imageUrl
    case interests
    case job
    case introduce
    case school
    case blueCheck
  }
  
  var toGender: Gender {
    if gender == "FEMALE" {
      return .female
    }
    if gender == "MALE" {
      return .male
    }
    return .male
  }
  
  var toAuthority: Authority {
    if authority == "ANONYMOUS" {
      return .anonymous
    }
    if authority == "USER" {
      return .user
    }
    if authority == "ADMIN" {
      return .admin
    }
    return .anonymous
  }
  
  public func toDomain() -> UserData {
    return UserData(
      nickname: nickname,
      mobileNumber: mobileNumber,
      birth: birth,
      gender: toGender,
      mbti: mbti,
      authority: toAuthority,
      address: address,
      imageUrl: imageUrl,
      interests: interests,
      job: job,
      introduce: introduce,
      school: school,
      blueCheck: blueCheck
    )
  }
}
