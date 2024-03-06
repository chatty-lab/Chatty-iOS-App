//
//  UserProfile.swift
//  DomainUser
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation
import DomainUserInterface

public struct UserProfile: UserProfileProtocol {
  public let nickname: String
  public let mobileNumber: String
  public let birth: String
  public let gender: String
  public let mbti: String
  public let interests: [String]
  public let authority: String
  public let address: String?
  public let imageUrl: String?
  public let job: String?
  public let introduce: String?
  public let school: String?
  public let blueCheck: Bool
  public let unlock: Bool
  
  public init(nickname: String, mobileNumber: String, birth: String, gender: String, mbti: String, interests: [String], authority: String, address: String?, imageUrl: String?, job: String?, introduce: String?, school: String?, blueCheck: Bool, unlock: Bool) {
    self.nickname = nickname
    self.mobileNumber = mobileNumber
    self.birth = birth
    self.gender = gender
    self.mbti = mbti
    self.interests = interests
    self.authority = authority
    self.address = address
    self.imageUrl = imageUrl
    self.job = job
    self.introduce = introduce
    self.school = school
    self.blueCheck = blueCheck
    self.unlock = unlock
  }
}
