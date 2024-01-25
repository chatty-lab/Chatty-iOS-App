//
//  CustomAlertButton.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/6/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

open class CustomAlertButton: BaseControl, Touchable, Highlightable {
  // MARK: - View Property
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
  }
  
  // MARK: - Stored Property
  public var title: String? {
    didSet {
      setTitle(title)
    }
  }
  
  // MARK: - Rx Property
  public let touchEventRelay: RxRelay.PublishRelay<Void> = .init()
  
  // MARK: - StateConfigurable
  public var configurations: [State : Configuration] = [:]
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  // MARK: - Initialize Method
  public override init(frame: CGRect) {
    super.init(frame: frame)
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
  
  private func setTitle(_ title: String?) {
    titleLabel.text = title
  }
}

extension CustomAlertButton: StateConfigurable {
  public enum State {
    case positive
    case negative
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

