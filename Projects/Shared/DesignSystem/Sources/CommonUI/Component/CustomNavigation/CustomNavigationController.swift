//
//  CustomNavigationController.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/30/23.
//

import UIKit
import RxSwift

/// `CustomNavigationController`는 NavigationController에서 공통적으로 처리하는 로직의 인터페이스를 정의해요.
///
/// __Method__
/// - `configureUI`: UI과 관련된 설정을 적용하는 메소드에요.
///   이 메소드는 컨트롤러의 UI를 설정하는데 사용되고, viewDidLoad 시점에 실행돼요.
///
public final class CustomNavigationController: UINavigationController, Bindable {
  // MARK: - View Property
  private var customNavigationBarConfigStack: [CustomNavigationBarConfiguration] = []
  
  private var customNavigationBar: CustomNavigationBar = CustomNavigationBar()
  
  public var customNavigationBarConfig: CustomNavigationBarConfiguration = .init() {
    willSet {
      if !customNavigationBarConfigStack.contains(where: { $0 == newValue }) {
        customNavigationBarConfigStack.append(newValue)
      }
      setCustomNavigationBar(newValue)
    }
  }
  
  // MARK: - Life Method
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    setupBackgroundIfNotSet()
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - BaseNavigation Delegate
  public weak var baseDelegate: BaseNavigationDelegate?
  
  // MARK: - Initialize Method
  public init() {
    super.init(nibName: nil, bundle: nil)
    bind()
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UIConfigurable
  public func configureUI() {
    disableDefaultNavigationBar()
    setupCustomNavigationBar()
  }
  
  // MARK: - Navigation Delegate
  public override func popViewController(animated: Bool) -> UIViewController? {
    let vc = super.popViewController(animated: animated)
    let _ = customNavigationBarConfigStack.popLast()
    if let config = customNavigationBarConfigStack.last {
      setCustomNavigationBar(config)
    }
    setBackButton(viewControllers)
    return vc
  }
  
  public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: animated)
    setBackButton(viewControllers)
  }
}

extension CustomNavigationController {
  public func bind() {
    customNavigationBar.touchEventRelay
      .bind(with: self) { owner, touch in
        switch touch {
        case .back:
          let _ = owner.popViewController(animated: true)
          owner.baseDelegate?.popViewController()
        }
      }
      .disposed(by: disposeBag)
  }
  
  public func setCustomNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    if hidden {
      if animated {
        customNavigationBar.fadeOut([customNavigationBar], alpha: .transparent) { [weak self] in
          self?.customNavigationBar.removeFromSuperview()
        }
      } else {
        customNavigationBar.removeFromSuperview()
      }
    } else {
      setupCustomNavigationBar()
      if animated {
        customNavigationBar.fadeIn([customNavigationBar], alpha: .full)
      }
    }
  }
  
  private func setupCustomNavigationBar() {
    view.addSubview(customNavigationBar)
    customNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(52)
    }
  }
  
  private func setCustomNavigationBar(_ config: CustomNavigationBarConfiguration) {
    customNavigationBar.setNavigation(with: config)
  }
  
  private func setBackButton(_ viewControllers: [UIViewController]) {
    // 자식 뷰 컨트롤러가 2개 이상일 경우
    guard viewControllers.count > 1 else {
      customNavigationBar.backButton = nil
      return
    }
    
    // 네비게이션 바의 백 버튼이 설정되지 않은 경우
    guard customNavigationBar.backButton == nil else { return }
    
    let button = CustomNavigationBarButton(image: UIImage(asset: Images.arrowLeft)!)
    customNavigationBar.backButton = button
  }
  
  private func setupBackgroundIfNotSet() {
    if self.view.backgroundColor == nil {
      self.view.backgroundColor = SystemColor.basicWhite.uiColor
    }
  }
  
  private func disableDefaultNavigationBar() {
    setNavigationBarHidden(true, animated: false)
  }
}

public protocol BaseNavigationDelegate: AnyObject {
  func popViewController()
}
