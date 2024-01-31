//
//  Fadeable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/3/24.
//

import UIKit

public protocol Fadeable: UIView {
  func fadeIn(_ view: [UIView?], duration: Duration, alpha: Alpha, completion: (() -> Void)?)
  func fadeOut(_ view: [UIView?], duration: Duration, alpha: Alpha, completion: (() -> Void)?)
  func flashAlpha(lowAlpha: CGFloat, highAlpha: CGFloat, duration: Duration, completion: (() -> Void)?)
}

public extension Fadeable {
  func fadeIn(_ view: [UIView?], duration: Duration = .normal, alpha: Alpha, completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: duration.value) {
      view.forEach { view in
        guard let view else { return }
        view.alpha = alpha.value
      }
    } completion: { _ in
      completion?()
    }
    
  }
  
  func fadeOut(_ view: [UIView?], duration: Duration = .normal, alpha: Alpha, completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: duration.value) {
      view.forEach { view in
        guard let view else { return }
        view.alpha = alpha.value
      }
    } completion: { _ in
      completion?()
    }
  }
  
  func flashAlpha(lowAlpha: CGFloat, highAlpha: CGFloat, duration: Duration, completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: duration.value / 2, animations: {
      self.alpha = lowAlpha
    }) { _ in
      UIView.animate(withDuration: duration.value / 2, animations: {
        self.alpha = highAlpha
      }, completion: { _ in
        completion?()
      })
    }
  }
}

public enum Alpha {
  case full
  case transparent
  case custom(value: CGFloat)
  
  var value: CGFloat {
    switch self {
    case .full:
      return 1
    case .transparent:
      return 0
    case .custom(let value):
      return value
    }
  }
}

public enum Duration {
  case fast
  case normal
  case slow
  case custom(TimeInterval)
  
  var value: TimeInterval {
    switch self {
    case .fast:
      return 0.12
    case .normal:
      return 0.25
    case .slow:
      return 0.3
    case .custom(let timeInterval):
      return timeInterval
    }
  }
}
