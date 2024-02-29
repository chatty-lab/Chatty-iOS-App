//
//  EditGenderButton.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//


import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SharedDesignSystem

final class EditGenderButton: UIControl, Touchable, Highlightable {
  // MARK: - View Property
  private let imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: - Rx Property
  let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let touchEventRelay = PublishRelay<Void>()
  
  // MARK: - StateConfigurable Property
  public var configurations: [State : Configuration] = [:]
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  // MARK: - Initialize Method
  required init() {
    super.init(frame: .init())
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension EditGenderButton {
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
      $0.size.equalTo(32)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
  }
}

extension EditGenderButton: StateConfigurable {
  enum State {
    case selected
    case deselected
  }
  
  struct Configuration {
    let backgroundColor: UIColor
    let borderColor: UIColor
    let isEnabled: Bool
  }
  
  func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    self.layer.borderColor = config.borderColor.cgColor
    self.layer.borderWidth = 1
    self.backgroundColor = config.backgroundColor
    self.isEnabled = config.isEnabled
  }
}

extension EditGenderButton {
  func setImage(_ gender: MatchGender) {
    self.imageView.image = gender.image
  }
}
