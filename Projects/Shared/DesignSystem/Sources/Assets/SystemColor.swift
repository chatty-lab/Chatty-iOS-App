//
//  SystemColor.swift
//  SharedDesignSystem
//
//  Created by 윤지호 on 1/3/24.
//

import UIKit

public enum SystemColor {
  /// 272727
  case basicBlack
  /// FEFEFE
  case basicWhite
  /// F8F8F8
  case gray100
  /// E9E9E9
  case gray200
  /// DDDDDD
  case gray300
  /// BBBBBB
  case gray400
  /// AAAAAA
  case gray500
  /// 777777
  case gray600
  /// 555555
  case gray700
  /// 333333
  case gray800
  /// FFF4F6
  case primaryLight
  /// FFE6EA
  case primaryMedium
  /// F32F4C
  case primaryNormal
  /// E6E6E6
  case neutralStroke
  /// FBB9C2
  case primaryStroke
  /// DC0328
  case systemErrorRed
  
  public var uiColor: UIColor {
    switch self {
    case .basicBlack:
      UIColor(asset: Colors.basicBlack)!
    case .basicWhite:
      UIColor(asset: Colors.basicWhite)!
    case .gray100:
      UIColor(asset: Colors.gray100)!
    case .gray200:
      UIColor(asset: Colors.gray200)!
    case .gray300:
      UIColor(asset: Colors.gray300)!
    case .gray400:
      UIColor(asset: Colors.gray400)!
    case .gray500:
      UIColor(asset: Colors.gray500)!
    case .gray600:
      UIColor(asset: Colors.gray600)!
    case .gray700:
      UIColor(asset: Colors.gray700)!
    case .gray800:
      UIColor(asset: Colors.gray800)!
    case .primaryLight:
      UIColor(asset: Colors.primaryLight)!
    case .primaryMedium:
      UIColor(asset: Colors.primaryMedium)!
    case .primaryNormal:
      UIColor(asset: Colors.primaryNormal)!
    case .primaryStroke:
      UIColor(asset: Colors.primaryStroke)!
    case .neutralStroke:
      UIColor(asset: Colors.neutralStroke)!
    case .systemErrorRed:
      UIColor(asset: Colors.primaryNormal)!
    }
  }
}
