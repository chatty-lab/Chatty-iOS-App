//
//  BaseView.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit

/// `BaseView`는 View에서 공통적으로 처리하는 로직의 인터페이스를 정의해요.
///
/// __Method__
/// - `configureUI`: UI과 관련된 설정을 적용하는 메소드에요.
///   이 메소드는 뷰의 UI를 설정하는데 사용되고, 뷰가 Initialize되는 시점에 실행돼요.
///   `BaseView`를 상속 받는 뷰는 `configureUI` 메소드를 재정의해서 사용해요.
///   
/// - `bind`: RxSwift 이벤트 스트림을 구독하거나 사용자 상호작용에 따라 이벤트를 방출하는 로직을 실행해요.
///   `BaseView`의 서브 클래스는 `bind` 메서드를 재정의하여 구체적인 바인딩 로직을 구현할 수 있어요.
///
open class BaseView: UIView, UIConfigurable, Bindable {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    bind()
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UIConfigurable
  open func configureUI() {
    
  }
  
  // MARK: - Bindable
  open func bind() {
    
  }
}
