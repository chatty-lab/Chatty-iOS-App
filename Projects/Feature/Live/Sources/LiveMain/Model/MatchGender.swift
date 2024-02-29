//
//  MatchGender.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/28/24.
//

import UIKit
import SharedDesignSystem

public enum MatchGender {
  case male
  case female
  case all
  
  var text: String {
    switch self {
    case .male:
      return "남자"
    case .female:
      return "여자"
    case .all:
      return "모두"
    }
  }
  
  var image: UIImage {
    switch self {
    case .male:
      return Images.manRaisingHandLightSkinTone.image
    case .female:
      return Images.womanRaisingHandLightSkinTone.image
    case .all:
      return Images.personShruggingLightSkinTone.image
    }
  }
}
