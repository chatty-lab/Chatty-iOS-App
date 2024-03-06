//
//  ChatHeaderItem.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/24/24.
//

import UIKit
import RxSwift
import RxCocoa
import SharedDesignSystem

public final class ChatHeaderItem: BaseView, StateConfigurable, Touchable {
  private lazy var label: UILabel = UILabel().then {
    $0.font = SystemFont.title02.font
    $0.text = title
  }
  
  public var touchEventRelay: PublishRelay<Void> = .init()
  
  private let disposeBag = DisposeBag()
  
  public var configurations: [State : Configuration] = [
    .selected: Configuration(textColor: SystemColor.basicBlack.uiColor),
    .unSelected: Configuration(textColor: SystemColor.gray400.uiColor)
  ]
  
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  private let title: String
  
  public func updateForCurrentState() {
    guard let state = currentState,
          let config = configurations[state] else { return }
    label.textColor = config.textColor
  }
  
  public override func configureUI() {
    addSubview(label)
    label.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  public override func bind() {
    self.rx.tapGesture()
      .map { _ in () }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  init(title: String) {
    self.title = title
    super.init(frame: .zero)
  }
  
  public enum State {
    case selected
    case unSelected
  }
  
  public struct Configuration {
    let textColor: UIColor
  }
}
