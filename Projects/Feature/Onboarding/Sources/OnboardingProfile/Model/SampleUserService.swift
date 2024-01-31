//
//  SampleUserService.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/13/24.
//

import UIKit

public final class SampleUserService {
  static var profileData: ProfileState = .init(nickName: "nickName", gender: .none, birth: Date.now, interest: [], mbti: .init())
  
  public static func setNickNameDate(_ nickName: String) {
    profileData.nickName = nickName
  }
  
  public static func setImage(_ image: UIImage) {
    profileData.porfileImage = image
  }
  
  public static func setDate(_ data: ProfileState) {
    profileData = data
  }
  
  public static func fetchDate() -> ProfileState {
    return profileData
  }
}
