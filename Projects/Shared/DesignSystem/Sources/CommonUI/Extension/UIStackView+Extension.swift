//
//  UIStackView+Extension.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/25/24.
//

import UIKit

public extension UIStackView {
  func removeAllArrangedSubViews() {
    self.arrangedSubviews.forEach {
      self.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }
}
