//
//  OnboardingNickNameCoordinatorView.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

public final class OnboardingNickNameView: BaseView, Touchable {
  // MARK: - View Property
  private let titleTextView: TitleTextView = TitleTextView()
  
  private let bottomLineTextField: ButtomLineTextField2 = ButtomLineTextField2()
  
  private let checkBoxImageView: CheckMarkCircleView = CheckMarkCircleView().then {
    $0.backgroundColor = .red
  }
  
  private let bottomLine: UILabel = UILabel().then {
    $0.font = SystemFont.caption03.font
    $0.textColor = SystemColor.systemErrorRed.uiColor
    $0.backgroundColor = .brown
  }
  
  private let warningLabel: UILabel = UILabel().then {
    $0.text = ProfileType.nickName.warningDescription
    $0.font = SystemFont.caption02.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  private let continueButton: FillButton = FillButton().then {
    typealias Configuration = FillButton.Configuration
    let disabledConfig = Configuration(backgroundColor: SystemColor.gray300.uiColor, isEnabled: false)
    let enabledCofig = Configuration(backgroundColor: SystemColor.primaryNormal.uiColor, isEnabled: true)
    
    $0.title = "계속하기"
    $0.setState(enabledCofig, for: .enabled)
    $0.setState(disabledConfig, for: .disabled)
  }
  
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  public let textRelay = BehaviorRelay<String>(value: "")
  
  // MARK: - Touchable Property
  public let touchEventRelay: PublishRelay<TouchType> = .init()
  
  // MARK: - Life Cycle
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UIConfigurable
  public override func configureUI() {
    setupTitleTextView()
    setupCheckableTextField()
    setupcheckBoxImageView()
    setupBottomLine()
    setupContinueButton()
  }
  
  // MARK: - UIBindable
  public override func bind() {
    continueButton.touchEventRelay
      .map { TouchType.continueButton }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
    
//    checkBoxImageView.didTouch
//      .map { TouchType.removeText }
//      .bind(to: self.didTouch)
//      .disposed(by: disposeBag)
    
    bottomLineTextField.textField.rx.text
      .map { $0 ?? "" }
      .bind(to: textRelay)
      .disposed(by: disposeBag)
  }
}

extension OnboardingNickNameView {
  public enum TouchType {
    case removeText
    case continueButton
  }

  private func setupTitleTextView() {
    addSubview(titleTextView)
    titleTextView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(111)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(126)
    }
  }
  private func setupCheckableTextField() {
    addSubview(bottomLineTextField)
    bottomLineTextField.snp.makeConstraints {
      $0.top.equalTo(titleTextView.snp.bottom).offset(64)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(50)
    }
  }
  private func setupcheckBoxImageView() {
    addSubview(checkBoxImageView)
    checkBoxImageView.snp.makeConstraints {
      $0.width.equalTo(22)
      $0.size.equalTo(22)
      $0.trailing.equalTo(bottomLineTextField.snp.trailing).offset(-18)
      $0.centerY.equalTo(bottomLineTextField.snp.centerY)
    }
  }
  private func setupBottomLine() {
    addSubview(bottomLine)
    bottomLine.snp.makeConstraints {
      $0.top.equalTo(bottomLineTextField.snp.bottom)
      $0.height.equalTo(14)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
  }
  private func setupContinueButton() {
    addSubview(continueButton)
    continueButton.snp.makeConstraints {
      $0.height.equalTo(52)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
    }
  }
  
}

extension OnboardingNickNameView {
  public func updateTextFieldBottomLine(_ state: CheckedResultType) {
//    switch state {
//    case .outOfRange, .duplication:
//      // bottomLineState
//      ""
//    case .none:
//      // bottomLineState
//      ""
//    }
    warningLabel.text = state.description
  }
  public func updateContinueButtonEnabled(_ state: Bool) {
    if state {
      continueButton.currentState = .enabled
    } else {
      continueButton.currentState = .disabled
    }
  }
}
