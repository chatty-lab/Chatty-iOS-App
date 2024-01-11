//
//  Zoomable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/7/24.
//

import UIKit

public protocol Zoomable: UIView {
  func zoomInAndOut(scale: CGFloat, duration: Duration, completion: (() -> Void)?)
}

public extension Zoomable {
  func zoomInAndOut(scale: CGFloat, duration: Duration, completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: duration.value / 2, animations: {
      self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }) { _ in
      UIView.animate(withDuration: duration.value / 2, animations: {
        self.transform = CGAffineTransform.identity
      }, completion: { _ in
        completion?()
      })
    }
  }
}
