//
//  InputReceivable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/5/24.
//

import UIKit
import RxCocoa

/// `InputReceivable` 프로토콜은 UIView 또는 그 서브 클래스에서 다양한 입력 이벤트를 처리하기 위한 인터페이스를 정의합니다.
///
/// 이 프로토콜을 준수하는 객체는 텍스트 입력, 선택, 날짜 선택 등의 이벤트를 `InputEventType` 열거형을 사용하여 `inputEventRelay`를 통해 전달합니다.
///
/// __AssociatedType__
/// `InputEventType`은 각각의 입력 이벤트 유형을 나타내는 열거형입니다.
///
/// __Property__
/// `inputEventRelay`는 입력 이벤트를 방출하는 PublishRelay입니다.
/// 뷰 계층 간에는 inputEvent를 통해 이벤트를 방출, 구독합니다.
///
public protocol InputReceivable: UIView {
  associatedtype InputEventType
  var inputEventRelay: PublishRelay<InputEventType> { get }
}
