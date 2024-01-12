//
//  AppFrame.swift
//  SharedDesignSystem
//
//  Created by 윤지호 on 1/13/24.
//

import UIKit

/// 사용자 기기의 frame이에요
extension CGRect {
  public static let appFrame: CGRect = {
    let vc = UIViewController()
    return vc.view.frame
  }()
}
