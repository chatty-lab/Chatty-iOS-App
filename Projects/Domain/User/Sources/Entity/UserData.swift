//
//  UserData.swift
//  DomainUserInterface
//
//  Created by HUNHIE LEE on 2/3/24.
//

import Foundation
import DomainUserInterface

public struct UserData: UserDataProtocol {
  public var nickname: String
  public var mobileNumber: String
  public var birth: String?
  public var gender: String?
  public var mbti: String?
  public var authority: String
  public var address: String?
  public var imageUrl: String?
  public var imageData: Data?
  public var interests: [Interest]
  public var job: String?
  public var introduce: String?
  public var school: String?
  public var blueCheck: Bool
  
  public init(nickname: String, mobileNumber: String, birth: String? = nil, gender: String? = nil, mbti: String? = nil, authority: String, address: String? = nil, imageUrl: String? = nil, imageData: Data? = nil, interests: [Interest] = [], job: String? = nil, introduce: String? = nil, school: String? = nil, blueCheck: Bool) {
    self.nickname = nickname
    self.mobileNumber = mobileNumber
    self.birth = birth
    self.gender = gender
    self.mbti = mbti
    self.authority = authority
    self.address = address
    self.imageUrl = imageUrl
    self.interests = interests
    self.job = job
    self.introduce = introduce
    self.school = school
    self.blueCheck = blueCheck
  }
}
