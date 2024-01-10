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
  public let baseNavigationBar: CustomNavigationBar = CustomNavigationBar()
  
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
    setupBaseNavigationBar()
  }
  
  // MARK: - Navigation Delegate
  public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    setBackButton(navigationController)
  }
  
  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    
  }
}

extension CustomNavigationController {
  public func bind() {
    baseNavigationBar.touchEventRelay
      .bind(with: self) { owner, touch in
        switch touch {
        case .back:
          owner.popViewController(animated: true)
          owner.baseDelegate?.popViewController()
        }
      }
      .disposed(by: disposeBag)
  }
  
  public func setBaseNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    if hidden {
      if animated {
        baseNavigationBar.fadeOut(baseNavigationBar, alpha: .transparent) { [weak self] in
          self?.baseNavigationBar.removeFromSuperview()
        }
      } else {
        baseNavigationBar.removeFromSuperview()
      }
    } else {
      if animated {
        setupBaseNavigationBar()
        baseNavigationBar.fadeIn(baseNavigationBar, alpha: .full)
      } else {
        setupBaseNavigationBar()
      }
    }
  }
  
  private func setupBaseNavigationBar() {
    view.addSubview(baseNavigationBar)
    baseNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(52)
    }
  }
  
  private func setBackButton(_ navigationController: UINavigationController) {
    guard navigationController.viewControllers.count > 1 else { return }
    let button = CustomNavigationBarButton<Void>(image: UIImage(asset: Images.arrowLeft)!)
    baseNavigationBar.backButton = button
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
