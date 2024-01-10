//
//  ProfileType.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import Shared

public struct ProfileState {
  var type: ProfileType
  var nickName: String
  var gender: Gender
  var porfileImage: UIImage? = nil
  var birth: Date
  var mbti: MBTI
}
