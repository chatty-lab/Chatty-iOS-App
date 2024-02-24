//
//  ProfileType.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import Shared
import SharedUtil
import DomainUserInterface

public struct ProfileState {
  var nickName: String
  var gender: Gender
  var porfileImage: UIImage? = nil
  var birth: Date
  var interest: [String]
  var mbti: MBTI
  
  init(userData: UserDataProtocol) {
    self.nickName = userData.nickname
    switch userData.gender {
    case "MALE":
      self.gender = .male
    case "FEMALE":
      self.gender = .female
    default:
      self.gender = .none
    }
//    self.porfileImage = userData.imageUrl
    self.birth = Date().toDate(userData.birth)
    self.interest = []
    self.mbti = MBTI(mbti: userData.mbti)
  }
  
  init(nickName: String, gender: Gender, porfileImage: UIImage? = nil, birth: Date, interest: [String], mbti: MBTI) {
    self.nickName = nickName
    self.gender = gender
    self.porfileImage = porfileImage
    self.birth = birth
    self.interest = interest
    self.mbti = mbti
  }
}
