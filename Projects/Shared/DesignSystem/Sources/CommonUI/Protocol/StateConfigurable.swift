//
//  StateConfigurable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit

/// `StateConfigurable` 프로토콜은 UIView 또는 그 서브 클래스에서 다양한 상태에 따른 구성(configuration)을 관리해요.
///
/// 이 프로토콜을 준수하는 객체는 `setState`와 `updateForCurrentState` 메소드를 사용하여 상태 별 구성을 설정하고 적용해요.
///
/// __Properties__
///
/// - `configurations`: 각 상태에 대한 구성을 저장하는 딕셔너리에요.
/// - `currentState`: 현재 뷰의 상태를 나타내는 프로퍼티에요.
///
/// __Method__
///
/// - `setState`: 특정 상태에 대한 구성을 설정해요.
/// - `updateForCurrentState`: 현재 상태에 맞게 뷰를 업데이트해요.
///
public protocol StateConfigurable: UIView {
  associatedtype State: Hashable
  associatedtype Configuration
  
  var configurations: [State: Configuration] { get set }
  var currentState: State? { get set }
  
  func setState(_ config: Configuration, for state: State) -> Void
  func updateForCurrentState()
}

public extension StateConfigurable {
  func setState(_ config: Configuration, for state: State) {
    self.configurations[state] = config
  }
}
