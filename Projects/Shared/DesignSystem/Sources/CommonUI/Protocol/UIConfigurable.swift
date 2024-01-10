//
//  UIConfigurable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import Foundation

/// `UIConfigurable` 프로토콜은 객체의 사용자 인터페이스를 설정하는 기능을 제공해요.
///
/// 이 프로토콜을 준수하는 객체는 `configureUI` 메소드를 사용하여 UI 구성을 정의해요. 주로 뷰 컨트롤러나 커스텀 뷰에서 사용돼요.
///
/// __Method__
///
/// - `configureUI`: 객체의 사용자 인터페이스를 설정하는 메소드에요.
///
public protocol UIConfigurable: AnyObject {
  func configureUI()
}
