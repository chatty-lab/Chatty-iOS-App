//
//  Font.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit

enum Font {
  case Pretendard(Pretendard)
  
  func of(size: CGFloat) -> UIFont {
    switch self {
    case .Pretendard(let pretendardWeight):
      return UIFont(name: pretendardWeight.fontFamilyName, size: size)!
    }
  }
}

enum Pretendard: String {
  case Black
  case Bold, ExtraBold
  case Light, ExtraLight
  case Medium
  case Regular
  case SemiBold
  case Thin
  
  var fontFamilyName: String {
    return "Pretendard-\(self.rawValue)"
  }
}
