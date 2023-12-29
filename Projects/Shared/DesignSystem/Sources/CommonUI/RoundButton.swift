//
//  RoundButton.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

open class RoundButton: UIButton, Touchable {
  private let text: String
  private var customConfiguration = UIButton.Configuration.filled()
  private let disposeBag = DisposeBag()
  public let didTouch: RxRelay.PublishRelay<Void> = .init()
  
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  public var configurations: [State : Configuration] = [:]
  
  public init(text: String) {
    self.text = text
    super.init(frame: .zero)
    
    bind()
    configureUI()
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RoundButton {
  private func bind() {
    self.rx.tap
      .map { _ in Void() }
      .bind(to: didTouch)
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    var titleAttr = AttributedString(stringLiteral: text)
    titleAttr.font = Font.Pretendard(.SemiBold).of(size: 16)
    titleAttr.foregroundColor = UIColor(asset: Colors.basicWhite)
    
    customConfiguration.attributedTitle = titleAttr
    customConfiguration.titleAlignment = .center
    
    configuration = customConfiguration
    
    layer.cornerRadius = 6
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
    configuration?.background.backgroundColor = config.backgroundColor
    isEnabled = config.isEnabled
  }
}
