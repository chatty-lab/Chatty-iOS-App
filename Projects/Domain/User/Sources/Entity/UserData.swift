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
  public var birth: String
  public var gender: String
  public var mbti: String
  public var address: String?
  public var authority: String
  public var imageUrl: String
  
  public init(nickname: String, mobileNumber: String, birth: String, gender: String, mbti: String, address: String? = nil, authority: String, imageUrl: String) {
    self.nickname = nickname
    self.mobileNumber = mobileNumber
    self.birth = birth
    self.gender = gender
    self.mbti = mbti
    self.address = address
    self.authority = authority
    self.imageUrl = imageUrl
  }
}