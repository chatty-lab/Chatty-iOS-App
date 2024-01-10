//
//  Highlightable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/30/23.
//

import UIKit

/// `Highlightable` 프로토콜은 UIView 또는 그 서브 클래스에서 투명도를 변경하는 애니메이션을 제공해요.
///
/// 이 프로토콜을 준수하는 객체는 `highlight`와 `unhighlight` 메소드를 사용하여 투명도 변화를 구현해요.
///
/// __Method__
///
/// - `highlight`: 뷰의 투명도를 줄여 하이라이트 효과를 적용해요.
/// - `unhighlight`: 뷰의 투명도를 원래대로 되돌려요.
///
public protocol Highlightable: UIView {
  func highlight(_ view: UIView)
  func unhighlight(_ view: UIView)
}

public extension Highlightable {
  func highlight(_ view: UIView) {
    UIView.animate(withDuration: 0.1, animations: {
      view.alpha = 0.65
    })
  }
  
  func unhighlight(_ view: UIView) {
    UIView.animate(withDuration: 0.1, animations: {
      view.alpha = 1.0
    })
  }
}
