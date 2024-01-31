//
//  CustomAlertController.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/4/24.
//

import UIKit
import RxSwift
import RxCocoa

public protocol CustomAlertDelegate: AnyObject {
  func destructiveAction()
  func cancelAction()
}

public final class CustomAlertController: BaseController {
  // MARK: - View Property
  private let alertView: CustomAlertView
  
  private let dimmedView: DimmedView = DimmedView()
  
  // MARK: - Delegate
  public weak var delegate: CustomAlertDelegate?
  
  // MARK: - Initialize Method
  public init(alertView: CustomAlertView) {
    self.alertView = alertView
    super.init()
  }
  
  deinit {
    print("해제됨: CustomAlertController")
  }
  
  // MARK: - Life Method
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    dimmedView.fadeIn([dimmedView], duration: .fast, alpha: .custom(value: 0.80)) { [weak self] in
      guard let self else { return }
      self.alertView.fadeIn([self.alertView], duration: .fast, alpha: .full)
      self.alertView.zoomInAndOut(scale: 1.01, duration: .fast)
      self.dimmedView.flashAlpha(lowAlpha: 0.75, highAlpha: 0.80, duration: .fast)
    }
  }
  
  // MARK: - UIConfigurable
  public override func configureUI() {
    view.backgroundColor = .clear
    view.addSubview(dimmedView)
    view.addSubview(alertView)
    dimmedView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    alertView.snp.makeConstraints {
      $0.centerY.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.75)
    }
  }
  
  public override func bind() {
    alertView.touchEventRelay
      .bind(with: self) { owner, touch in
        owner.dimmedView.fadeOut([owner.dimmedView], duration: .fast, alpha: .transparent)
        owner.alertView.shrink(owner.alertView, duration: .fast, with: .custom(0.65))
        owner.alertView.fadeOut([owner.alertView], duration: .fast, alpha: .transparent) {
          owner.dismiss(animated: false)
          switch touch {
          case .positive:
            owner.delegate?.destructiveAction()
          case .negative:
            owner.delegate?.cancelAction()
          }
        }
      }
      .disposed(by: disposeBag)
  }
}
