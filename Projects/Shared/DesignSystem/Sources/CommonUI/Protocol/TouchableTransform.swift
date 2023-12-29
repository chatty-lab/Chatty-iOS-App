//
//  TouchableTransform.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit

/// `TouchableTransform` 프로토콜은 UIControl 또는 그 서브 클래스에서 터치에 반응하는 변형(transform) 애니메이션을 제공해요.
///
/// 이 프로토콜을 준수하는 객체는 `shrink`와 `expand` 메소드를 사용하여 터치에 따른 애니메이션을 구현해요.
///
/// __Method__
///
/// - `shrink`: 뷰를 축소하는 애니메이션을 실행해요.
/// - `expand`: 뷰를 원래 크기로 확장하는 애니메이션을 실행해요.
///
public protocol TouchableTransform: UIControl {
  func shrink(_ view: UIView)
  func expand(_ view: UIView)
}

public extension TouchableTransform {
  func shrink(_ view: UIView) {
    UIView.animate(withDuration: 0.1, animations: {
      view.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
    })
  }
  
  func expand(_ view: UIView) {
    UIView.animate(withDuration: 0.1, animations: {
      view.transform = CGAffineTransform.identity
    })
  }
}
