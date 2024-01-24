//
//  Bindable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/30/23.
//

import Foundation

/// `Bindable` 프로토콜은 객체가 데이터 소스나 다른 요소에 바인딩을 설정하는 데 필요한 인터페이스를 제공해요.
///
/// 이 프로토콜을 준수하는 객체는 `bind` 메소드를 사용하여 데이터 바인딩 및 이벤트 처리를 설정해요.
///
/// __Method__
///
/// - `bind`: 객체의 이벤트 및 데이터 바인딩을 설정하는 메소드에요.
///
public protocol Bindable: AnyObject {
  func bind()
}
