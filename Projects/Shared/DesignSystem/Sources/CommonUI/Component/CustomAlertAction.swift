//
//  CustomAlertAction.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/6/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

open class CustomAlertAction: BaseControl, Touchable, Highlightable {
  // MARK: - View Property
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
  }
  
  // MARK: - Stored Property
  public var title: String?
  
  // MARK: - Rx Property
  public let touchEventRelay: RxRelay.PublishRelay<Void> = .init()
  
  // MARK: - StateConfigurable
  public var configurations: [State : Configuration] = [
    .destructive: .init(backgroundColor: SystemColor.primaryNormal.uiColor, textColor: SystemColor.basicWhite.uiColor),
    .cancel: .init(backgroundColor: SystemColor.basicWhite.uiColor, textColor: SystemColor.basicBlack.uiColor)
  ]
  public var currentState: State?
  
  // MARK: - Initialize Method
  public init(text: String?, style: Style) {
    self.title = text
    self.currentState = style
    super.init(frame: .zero)
    
    setTitle()
    updateForCurrentState()
  }
  
  // MARK: - Bindable
  open override func bind() {
    self.rx.controlEvent(.touchDown)
      .bind(with: self) { [weak self] owner, _ in
        guard let self else { return }
        owner.highlight(self)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
        self.rx.controlEvent(.touchDragExit).map { _ in Void() },
        self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { [weak self] _, _  in
      guard let self else { return }
      self.unhighlight(self)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .map { _ in Void() }
      .do { [weak self] _ in
        guard let self else { return }
        self.unhighlight(self)
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  // MARK: - UIConfigurable
  open override func configureUI() {
    layer.cornerRadius = 8
    
    setupTitleLabel()
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  private func setTitle() {
    titleLabel.text = title
  }
}

extension CustomAlertAction: StateConfigurable {
  public typealias State = Style
  
  public enum Style {
    case destructive
    case cancel
  }
  
  public struct Configuration {
    let backgroundColor: UIColor
    let textColor: UIColor
    
    public init(backgroundColor: UIColor, textColor: UIColor) {
      self.backgroundColor = backgroundColor
      self.textColor = textColor
    }
  }
  
  public func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    backgroundColor = config.backgroundColor
    titleLabel.textColor = config.textColor
  }
}
