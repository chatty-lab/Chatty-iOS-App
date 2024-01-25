//
//  BaseController.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import RxSwift
import RxGesture

/// `BaseController`는 Controller에서 공통적으로 처리하는 로직의 인터페이스를 정의해요.
///
/// 이 컨트롤러를 상속 받는 클래스는 인터페이스를 활용해 컨트롤러 내 공통 로직을 일관되게 작성할 수 있어요.
///
/// __Method__
/// - `configureUI`: UI과 관련된 설정을 적용하는 메소드에요.
///   이 메소드는 컨트롤러의 UI를 설정하는데 사용되고, viewDidLoad 시점에 실행돼요.
///
/// - `bind`: RxSwift 이벤트 스트림을 구독하거나 사용자 상호작용에 따라 이벤트를 방출하는 로직을 실행해요.
///   `BaseController`의 서브 클래스는 `bind` 메서드를 재정의하여 구체적인 바인딩 로직을 구현할 수 있어요.
///
open class BaseController: UIViewController, UIConfigurable, Bindable {
  public var disposeBag = DisposeBag()
  
  public weak var customNavigationController: CustomNavigationController? {
    return navigationController as? CustomNavigationController
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setNavigationBar()
    setupBackgroundIfNotSet()
    bind()
  }
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Set UI
  private func setupBackgroundIfNotSet() {
    if self.view.backgroundColor == nil {
      self.view.backgroundColor = SystemColor.basicWhite.uiColor
    }
  }
  
  // MARK: - UIConfigurable
  open func configureUI() {
    
  }
  
  open func setNavigationBar() {
    customNavigationController?.customNavigationBarConfig = CustomNavigationBarConfiguration()
  }
  
  // MARK: - Bindable
  open func bind() {
    
  }
  
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
