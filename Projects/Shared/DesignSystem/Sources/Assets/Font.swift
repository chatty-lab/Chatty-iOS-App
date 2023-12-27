//
//  Font.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit

public enum Font {
  case Pretendard(Pretendard)
  
  public func of(size: CGFloat) -> UIFont {
    switch self {
    case .Pretendard(let pretendardWeight):
      return UIFont(name: pretendardWeight.fontFamilyName, size: size)!
    }
  }
}

public enum Pretendard: String, CaseIterable {
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
