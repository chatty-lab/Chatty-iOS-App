//
//  ChangeableImageButton.swift
//  SharedDesignSystem
//
//  Created by 윤지호 on 1/12/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit

public final class ChangeableImageButton: UIControl, Touchable, Highlightable {
  // MARK: - View Property
  private let imageView: UIImageView = UIImageView()
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let touchEventRelay: PublishRelay<Void> = .init()
  
  // MARK: - StateConfigurable Property
  public var configurations: [State : Configuration] = [:]
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  // MARK: - Initalize Method
  public override init(frame: CGRect) {
    super.init(frame: frame)
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension ChangeableImageButton {
  private func bind() {
    self.rx.controlEvent(.touchDown)
      .bind(with: self) { owner, _ in
        owner.highlight(owner)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
      self.rx.controlEvent(.touchDragExit).map { _ in Void() },
      self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { owner, _ in
      owner.unhighlight(owner)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .map { _ in Void() }
      .withUnretained(self)
      .do { owner, _ in
        self.unhighlight(owner)
      }
      .map { _ in Void() }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension ChangeableImageButton: StateConfigurable {
  public enum State {
    case enabled
    case disabled
  }
  
  public struct Configuration {
    let image: UIImage
    let isEnabled: Bool
    
    public init(image: UIImage, isEnabled: Bool) {
      self.image = image
      self.isEnabled = isEnabled
    }
  }
  
  public func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    imageView.tintColor = SystemColor.gray300.uiColor
    imageView.image = config.image
    isEnabled = config.isEnabled
  }
}
