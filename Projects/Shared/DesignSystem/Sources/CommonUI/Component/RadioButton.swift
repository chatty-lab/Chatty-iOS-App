//
//  RadioButton.swift
//  SharedDesignSystem
//
//  Created by HUNHIE LEE on 1/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

open class RadioButton: BaseControl, Touchable {
  
  // MARK: - View Property
  private lazy var titleLabel: UILabel = UILabel().then {
    $0.text = title
    $0.font = SystemFont.title04.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  private let radioOuter: UIView = UIView().then {
    $0.layer.borderWidth = 1.8
  }
  
  private let radioInner: UIView = UIView()
  
  // MARK: - Stored Property
  public var title: String
  
  public let id: (any IntCaseIterable)
  
  public init(title: String, id: any IntCaseIterable) {
    self.title = title
    self.id = id
    super.init(frame: .zero)
  }
  
  // MARK: - Touchable
  public var touchEventRelay: PublishRelay<String> = .init()
  
  // MARK: - StateConfigurable
  public var configurations: [State: Configuration] = [
    .selected: .init(borderColor: SystemColor.primaryNormal.uiColor.cgColor, radioColor: SystemColor.primaryNormal.uiColor),
    .unSelected: .init(borderColor: SystemColor.gray200.uiColor.cgColor, radioColor: .clear)
  ]
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  // MARK: - UIBindable
  open override func bind() {
    self.rx.controlEvent(.touchUpInside)
      .map { self.title }
      .bind(with: self) { owner, title in
        owner.touchEventRelay.accept(title)
        owner.currentState = .selected
      }
      .disposed(by: disposeBag)
  }
  
  public override func configureUI() {
    layer.cornerRadius = 8
    layer.borderWidth = 1
    
    setupTitleLabel()
    setupRadioView()
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(18)
      $0.centerY.equalToSuperview()
    }
  }
  
  private func setupRadioView() {
    addSubview(radioOuter)
    radioOuter.addSubview(radioInner)
    
    radioOuter.snp.makeConstraints {
      $0.size.equalTo(22)
      $0.trailing.equalToSuperview().offset(-19)
      $0.centerY.equalToSuperview()
    }
    radioOuter.makeCircle(with: 22)
    
    radioInner.snp.makeConstraints {
      $0.size.equalTo(11)
      $0.center.equalToSuperview()
    }
    radioInner.makeCircle(with: 11)
  }
}

extension RadioButton: StateConfigurable {
  public enum State {
    case selected
    case unSelected
  }
  
  public struct Configuration {
    let borderColor: CGColor
    let radioColor: UIColor
  }
  
  public func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    layer.borderColor = config.borderColor
    radioOuter.layer.borderColor = config.borderColor
    radioInner.backgroundColor = config.radioColor
  }
}
