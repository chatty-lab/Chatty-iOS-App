//
//  BaseNavigationController.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/30/23.
//

import UIKit

public protocol NavigationConfigurator: UIConfigurable {
  func setNavigationBar()
}

/// `BaseNavigationController`는 NavigationController에서 공통적으로 처리하는 로직의 인터페이스를 정의해요.
///
/// __Method__
/// - `configureUI`: UI과 관련된 설정을 적용하는 메소드에요.
///   이 메소드는 컨트롤러의 UI를 설정하는데 사용되고, viewDidLoad 시점에 실행돼요.
///
public final class BaseNavigationController: UINavigationController {
  // MARK: - Life Method
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    setupBackgroundIfNotSet()
    disableDefaultNavigationBar()
  }
  
  // MARK: - NavigationConfigurator
  public weak var navigationConfigurator: NavigationConfigurator?
  
  // MARK: - Initialize Method
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UIConfigurable
  public func configureUI() {

  }
  
  private func setupBackgroundIfNotSet() {
    if self.view.backgroundColor == nil {
      self.view.backgroundColor = UIColor(asset: Colors.basicWhite)
    }
  }
  
  private func disableDefaultNavigationBar() {
    setNavigationBarHidden(true, animated: true)
  }
  
  public func willShow() {
    navigationConfigurator?.setNavigationBar()
  }
}
