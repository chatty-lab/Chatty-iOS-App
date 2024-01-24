//
//  Transformable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/8/24.
//

import UIKit

/// `Transformable` 프로토콜은 UIView 또는 그 서브 클래스에서 변형(transform) 애니메이션을 제공합니다.
///
/// 이 프로토콜을 준수하는 객체는 `shrink`와 `expand` 메소드를 사용하여 특정 `ScaleFactor`에 따라 뷰의 크기를 조절할 수 있습니다.
///
/// __Method__
///
/// - `shrink`: 지정된 `ScaleFactor`를 사용하여 뷰의 크기를 축소합니다. 애니메이션이 완료된 후에 선택적으로 실행할 클로저를 포함할 수 있습니다.
/// - `expand`: 지정된 `ScaleFactor`를 사용하여 뷰를 원래 크기로 되돌립니다. 애니메이션이 완료된 후에 선택적으로 실행할 클로저를 포함할 수 있습니다.
///
public protocol Transformable: UIView {
  func shrink(_ view: UIView, duration: Duration, with scale: ScaleFactor, completion: (() -> Void)?)
  func expand(_ view: UIView, duration: Duration, with scale: ScaleFactor, completion: (() -> Void)?)
}

public extension Transformable {
  func shrink(_ view: UIView, duration: Duration, with scale: ScaleFactor, completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: 0.1) {
      view.transform = scale.value
    } completion: { _ in
      completion?()
    }
  }
  
  func expand(_ view: UIView, duration: Duration, with scale: ScaleFactor, completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: 0.1) {
      view.transform = scale.value
    } completion: { _ in
      completion?()
    }

  }
}

public enum ScaleFactor {
  case custom(CGFloat)
  case customXY((x: CGFloat, y: CGFloat))
  case identity
  
  var value: CGAffineTransform {
    switch self {
    case .custom(let scale):
      return .init(scaleX: scale, y: scale)
    case .customXY((let x, let y)):
      return .init(scaleX: x, y: y)
    case .identity:
      return .identity
    }
  }
}
