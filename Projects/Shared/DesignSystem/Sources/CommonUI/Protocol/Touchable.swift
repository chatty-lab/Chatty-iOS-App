//
//  Touchable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import RxCocoa

/// `Touchable` 프로토콜은 UIView 또는 그 서브 클래스에서 터치 이벤트를 처리하기 위한 인터페이스를 정의해요.
///
/// 이 프로토콜을 준수하는 객체는 터치 이벤트를 `TouchEventType` 열거형을 사용하여 `touchEvent`를 통해 전달해요.
///
/// __AssociatedType__
/// `TouchEventType`은 각각의 터치 이벤트 유형을 나타내는 열거형이에요.
///
/// __Property__
/// `touchEvent`는 터치 이벤트를 방출하는 PublishRelay에요.
/// 뷰 계층 간에는 touchEvent를 통해 이벤트를 방출, 구독해요.
///
public protocol Touchable: UIView {
  associatedtype TouchEventType
  var touchEvent: PublishRelay<TouchEventType> { get }
}
