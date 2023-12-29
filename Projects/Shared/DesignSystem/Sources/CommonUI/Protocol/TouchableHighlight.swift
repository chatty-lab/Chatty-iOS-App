//
//  TouchableHighlight.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/30/23.
//

import UIKit

/// `TouchableHighlight` 프로토콜은 UIControl 또는 그 서브 클래스에서 터치 이벤트에 대응하여 투명도를 변경하는 애니메이션을 제공합니다.
///
/// 이 프로토콜을 준수하는 객체는 `highlight`와 `unhighlight` 메소드를 사용하여 투명도 변화를 구현합니다.
///
/// __Method__
///
/// - `highlight`: 파라미터로 넘겨 받은 뷰의 투명도를 줄여 하이라이트 효과를 적용합니다.
/// - `unhighlight`: 파라미터로 넘겨 받은 뷰의 투명도를 원래대로 복구합니다.
///
public protocol TouchableHighlight: UIControl {
  func highlight(_ view: UIView)
  func unhighlight(_ view: UIView)
}

public extension TouchableHighlight {
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
