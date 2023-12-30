//
//  BaseControl.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/30/23.
//

import UIKit

/// `BaseControl`는 UIControl의 서브 클래스에서 공통적으로 처리하는 로직의 인터페이스를 정의해요.
///
/// __Method__
/// - `configureUI`: UI과 관련된 설정을 적용하는 메소드에요.
///   이 메서드는 뷰의 UI를 설정하는데 사용되고, 뷰가 Initialize되는 시점에 실행돼요.
///   `BaseControl`를 상속 받는 클래스는 `configureUI` 메서드를 재정의해서 사용할 수 있어요.
///
/// - `bind`: RxSwift를 사용하여 이벤트를 구독하고 처리하는 메서드에요.
///   이 메서드를 사용해서 Rx Event Stream을 구독하고, 해당 이벤트에 대한 처리 작업을 수행해요.
///   `BaseControl`를 상속 받는 클래스는 `bind` 메서드를 재정의해서 사용할 수 있어요.
///
open class BaseControl: UIControl, UIConfigurable, Bindable {
  
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
