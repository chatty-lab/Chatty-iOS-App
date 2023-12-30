//
//  BaseController.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit

/// `BaseController`는 Controller에서 공통적으로 처리하는 로직의 인터페이스를 정의해요.
///
/// 이 컨트롤러를 상속 받는 클래스는 인터페이스를 활용해 컨트롤러 내 공통 로직을 일관되게 작성할 수 있어요.
///
/// __Properties__
/// - `uiConfigurator`: UIConfigurable 프로토콜을 준수하는 객체의 참조에요.
///   이 객체는 컨트롤러의 UI를 설정하는데 사용해요.
///
open class BaseController: UIViewController, UIConfigurable, Bindable {
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    setupBackgroundIfNotSet()
  }
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupBackgroundIfNotSet() {
    if self.view.backgroundColor == nil {
      self.view.backgroundColor = UIColor(asset: Colors.basicWhite)
    }
  }
  
  // MARK: - UIConfigurable
  open func configureUI() {
    
  }
  
  // MARK: - Bindable
  open func bind() {
    
  }
}
