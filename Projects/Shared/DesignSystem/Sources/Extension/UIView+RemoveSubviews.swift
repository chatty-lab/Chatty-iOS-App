//
//  UIView+RemoveSubviews.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/4/24.
//

import UIKit

public extension UIView {
  /// 뷰의 모든 하위 뷰를 제거해요.
  func removeAllSubviews() {
    subviews.forEach { $0.removeFromSuperview() }
  }
}
