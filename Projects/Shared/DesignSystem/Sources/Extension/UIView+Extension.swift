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
  
  /// 각 꼭지점 CornerRound 지정
  func setRoundCorners(corners: CACornerMask.ArrayLiteralElement, radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = CACornerMask(arrayLiteral: corners)
  }
  
  enum VerticalLocation {
    case bottom
    case top
    case left
    case right
  }
  
  /// 뷰의 특정 변에 그림자을 설정해요.
  func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.06, radius: CGFloat = 5.0, length: CGFloat = 4.0) {
    switch location {
    case .bottom:
      addShadow(offset: CGSize(width: 0, height: length), color: color, opacity: opacity, radius: radius)
    case .top:
      addShadow(offset: CGSize(width: 0, height: -length), color: color, opacity: opacity, radius: radius)
    case .left:
      addShadow(offset: CGSize(width: -length, height: 0), color: color, opacity: opacity, radius: radius)
    case .right:
      addShadow(offset: CGSize(width: length, height: 0), color: color, opacity: opacity, radius: radius)
    }
  }
  
  /// 뷰의 모든방향에 그림자를 설정해요.
  func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = offset
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = radius
  }
  
  /// 뷰의 특정 모서리에 곡률을 설정해요.
  func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
    layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
  }
}
