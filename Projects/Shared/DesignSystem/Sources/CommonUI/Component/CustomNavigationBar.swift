//
//  CustomNavigationBar.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/2/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

open class CustomNavigationBar: BaseView, Touchable, Fadeable {  
  // MARK: - View Property
  public var backButton: BaseControl? {
    didSet {
      setupBackButton(backButton)
    }
  }
  
  // MARK: - Touchable
  public var touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Initialize Method
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  // MARK: - UIConfigurable
  open override func configureUI() {

  }
  
  private func setupBackButton(_ backButton: BaseControl?) {
    guard let backButton,
              backButton.superview == nil else { return }
    addSubview(backButton)
    backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(24)
    }
    
    backButton.rx.controlEvent(.touchUpInside)
      .map { .back }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension CustomNavigationBar {
  public enum TouchEventType {
    case back
  }
}
