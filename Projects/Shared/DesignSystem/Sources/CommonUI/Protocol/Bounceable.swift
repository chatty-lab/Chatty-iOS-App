//
//  Bounceable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit

public protocol Bounceable: UIView {
  func bounce()
}

public extension Bounceable {
  func bounce() {
    UIView.animate(withDuration: 0.1, animations: {
      self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }) { _ in
      UIView.animate(withDuration: 0.1) {
        self.transform = CGAffineTransform.identity
      }
    }
  }
}
