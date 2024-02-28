//
//  UIView+Extension.swift
//  SharedDesignSystem
//
//  Created by HUNHIE LEE on 1/4/24.
//

import UIKit

public extension UIView {
  /// 뷰의 모든 하위 뷰를 제거해요.
  func removeAllSubviews() {
    subviews.forEach { $0.removeFromSuperview() }
  }
  
  /// 뷰를 둥글게 만들어요.
  func makeCircle(with: CGFloat) {
    self.layer.cornerRadius = with / 2
  }
  
  /// 뷰의 특정 모서리에 곡률을 설정해요.
  func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
    layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
  }
}
