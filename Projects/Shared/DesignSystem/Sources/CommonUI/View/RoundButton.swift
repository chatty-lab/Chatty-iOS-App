//
//  RoundButton.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

open class RoundButton: BaseControl, Touchable, TouchableHighlight, TouchableTransform {
  // MARK: - View Property
  private lazy var titleLabel: UILabel = UILabel().then {
    $0.text = title
    $0.textColor = UIColor(asset: Colors.basicWhite)
    $0.font = Font.Pretendard(.SemiBold).of(size: 16)
  }
  
  // MARK: - Stored Property
  private let title: String
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  public let touchEvent: RxRelay.PublishRelay<Void> = .init()
  
  // MARK: - StateConfigurable Property
  public var configurations: [State : Configuration] = [:]
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  public init(title: String) {
    self.title = title
    super.init(frame: .zero)
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func bind() {
    self.rx.controlEvent(.touchDown)
      .bind(with: self) { [weak self] owner, _ in
        guard let self else { return }
        owner.shrink(self)
        owner.highlight(self)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
        self.rx.controlEvent(.touchDragExit).map { _ in Void() },
        self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { [weak self] _, _  in
      guard let self else { return }
      self.expand(self)
      self.unhighlight(self)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .map { _ in Void() }
      .do { [weak self] _ in
        guard let self else { return }
        self.expand(self)
        self.unhighlight(self)
      }
      .bind(to: touchEvent)
      .disposed(by: disposeBag)
  }
  
  open override func configureUI() {
    layer.cornerRadius = 6
    
    setupTitleLabel()
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
}

extension RoundButton: StateConfigurable {
  public enum State {
    case enabled
    case disabled
  }
  
  public struct Configuration {
    let backgroundColor: UIColor
    let isEnabled: Bool
    
    public init(backgroundColor: UIColor, isEnabled: Bool) {
      self.backgroundColor = backgroundColor
      self.isEnabled = isEnabled
    }
  }
  
  public func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    backgroundColor = config.backgroundColor
    isEnabled = config.isEnabled
  }
}
