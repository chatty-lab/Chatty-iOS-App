//
//  MatchGender.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/28/24.
//

import UIKit
import DomainLiveInterface
import SharedDesignSystem

extension MatchGender {
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
