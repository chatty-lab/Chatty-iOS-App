//
//  UIView+Extension.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/25/24.
//

import UIKit

public extension UIView {
  func removeAllSubViews() {
    subviews.forEach { $0.removeFromSuperview() }
  }
}
