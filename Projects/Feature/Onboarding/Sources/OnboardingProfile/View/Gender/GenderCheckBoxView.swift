//
//  GenderCheckBoxView.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/3/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Then
import SnapKit
import SharedDesignSystem

public final class GenderCheckBoxView: UIControl, Touchable, Highlightable {
  
  public var genderType: Gender = .none {
    didSet {
      self.genderLabel.text = genderType.string
    }
  }
  // MARK: - View Property
  private let genderLabel: UILabel = UILabel().then {
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.title04.font
  }
  
  private let checkBoxImageView: CheckMarkCircleView = CheckMarkCircleView().then {
    typealias Configuration = CheckMarkCircleView.CheckMarkCircleConfiguration
    let uncheckedConfig = Configuration(tintColor: SystemColor.gray500.uiColor)
    let checkedConfig = Configuration(tintColor: SystemColor.primaryNormal.uiColor)
    
    $0.setState(uncheckedConfig, for: .unChecked)
    $0.setState(checkedConfig, for: .checked)
    $0.currentState = .unChecked
  }
  
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
  
  // MARK: - Initialize Method
  override init(frame: CGRect) {
    super.init(frame: frame)
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension GenderCheckBoxView {
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
    layer.borderWidth = 1
    layer.cornerRadius = 8
    layer.borderColor = SystemColor.gray200.uiColor.cgColor

    setupAllConsentLabel()
    setupCheckBoxImageView()
  }
  
  private func setupAllConsentLabel() {
    addSubview(genderLabel)
    genderLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(18)
      $0.centerY.equalToSuperview()
    }
  }
  
  private func setupCheckBoxImageView() {
    addSubview(checkBoxImageView)
    checkBoxImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-18)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(22)
    }
  }
}

extension GenderCheckBoxView: StateConfigurable {
  public enum State {
    case checked
    case unChecked
  }
  
  public struct Configuration {
    let tintColor: UIColor
    
    init(tintColor: UIColor) {
      self.tintColor = tintColor
    }
  }
  
  public func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    self.layer.borderColor = config.tintColor.cgColor
  }
}

extension GenderCheckBoxView {
  public func updateForCurrentState(_ gender: Gender) {
    if genderType == gender {
      currentState = .checked
      self.checkBoxImageView.currentState = .checked
    } else {
      currentState = .unChecked
      self.checkBoxImageView.currentState = .unChecked
    }
  }
}
