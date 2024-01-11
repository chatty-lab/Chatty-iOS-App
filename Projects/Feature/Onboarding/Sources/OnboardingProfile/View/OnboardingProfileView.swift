//
//  OnboardingProfileView.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SharedDesignSystem

public final class OnboardingProfileView: UIView {
  // MARK: - View Property
  private let containerView: UIView = UIView()
  private let titleTextView = TitleTextView()
  private let contentView: UIView = UIView()
  private let warningLabel: UILabel = UILabel().then {
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.caption02.font
  }
  private let continueButton: FillButton = FillButton().then {
    typealias Configuration = FillButton.Configuration
    let disabledConfig = Configuration(
      backgroundColor: SystemColor.gray300.uiColor,
      isEnabled: false
    )
    let enabledCofig = Configuration(
      backgroundColor: SystemColor.primaryNormal.uiColor,
      isEnabled: true
    )
    
    $0.title = "계속하기"
    $0.setState(enabledCofig, for: .enabled)
    $0.setState(disabledConfig, for: .disabled)
  }
  
  private weak var maleCheckBoxView: GenderCheckBoxView?
  private weak var femaleCheckBoxView: GenderCheckBoxView?
  private weak var birthDatePicker: UIDatePicker?
  private weak var profileImagePickerView: ProfileImagePickerView?
  private weak var mbtiView: MBTIView?
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touch Property
  public let touchEventRelay: PublishRelay<TouchType> = .init()
  
  // MARK: - Life Method
  public override init(frame: CGRect) {
    super.init(frame: frame)
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

extension OnboardingProfileView: Touchable {
  public enum TouchType {
    case tabGender(Gender)
    case setBirth(Date)
    case continueButton
    case tabImagePicker
    case toggleMBTI(MBTISeletedState, Bool)
  }
}

extension OnboardingProfileView {
  private func bind() {
    continueButton.touchEventRelay
      .map { TouchType.continueButton }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
  }
  private func bindGender() {
    maleCheckBoxView?.touchEventRelay
      .map { TouchType.tabGender(.male) }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
    
    femaleCheckBoxView?.touchEventRelay
      .map { TouchType.tabGender(.female) }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
  }
  private func bindBirth() {
    birthDatePicker?.rx.date
      .map { TouchType.setBirth($0) }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
  }
  private func bindProfileImage() {
    profileImagePickerView?.touchEventRelay
      .map { TouchType.tabImagePicker }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
  }
  private func bindMBTI() {
    mbtiView?.touchEventRelay
      .map { touch in TouchType.toggleMBTI(touch.0, touch.1) }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension OnboardingProfileView {
  private func configureUI() {
    setContainView()
  }
  
  private func setContainView() {
    addSubview(containerView)
    containerView.addSubview(titleTextView)
    containerView.addSubview(contentView)
    containerView.addSubview(warningLabel)
    containerView.addSubview(continueButton)
    
    containerView.snp.makeConstraints{
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    titleTextView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(112)
      $0.leading.trailing.equalToSuperview()
      $0.height.greaterThanOrEqualTo(75)
    }
    
    contentView.snp.makeConstraints {
      $0.top.equalTo(titleTextView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.lessThanOrEqualTo(400)
    }
    
    warningLabel.snp.makeConstraints {
      $0.height.equalTo(18)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(continueButton.snp.top).inset(-11)
    }
    
    continueButton.snp.makeConstraints {
      $0.height.equalTo(52)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(30)
    }
  }
  
  private func setupGenderCheckBoxView() {
    let maleCheckBoxView = GenderCheckBoxView()
    let femaleCheckBoxView = GenderCheckBoxView()
    maleCheckBoxView.genderType = .male
    femaleCheckBoxView.genderType = .female
    
    contentView.addSubview(maleCheckBoxView)
    contentView.addSubview(femaleCheckBoxView)
    
    femaleCheckBoxView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(56)
      $0.trailing.leading.equalToSuperview().inset(20)
      $0.height.equalTo(46)
    }
    maleCheckBoxView.snp.makeConstraints {
      $0.top.equalTo(femaleCheckBoxView.snp.bottom).offset(12)
      $0.trailing.leading.equalToSuperview().inset(20)
      $0.height.equalTo(46)
    }
    
    self.maleCheckBoxView = maleCheckBoxView
    self.femaleCheckBoxView = femaleCheckBoxView
  }
  
  private func setupDatePicker() { 
    let datePicker = UIDatePicker().then {
      $0.datePickerMode = .date
      $0.preferredDatePickerStyle = .wheels
    }
    contentView.addSubview(datePicker)
    datePicker.snp.makeConstraints {
      $0.top.equalToSuperview().inset(45)
      $0.leading.trailing.equalToSuperview().inset(39)
    }
    self.birthDatePicker = datePicker
  }
  
  private func setupProfileImagePicker() {
    let profileImagePickerView = ProfileImagePickerView()
    contentView.addSubview(profileImagePickerView)
    profileImagePickerView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(96)
      $0.leading.trailing.equalToSuperview()
    }
    self.profileImagePickerView = profileImagePickerView
  }
  
  private func setupMBTIView() {
    let mbtiView = MBTIView()
    contentView.addSubview(mbtiView)
    mbtiView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(56)
      $0.height.equalTo(200)
      $0.leading.trailing.equalToSuperview()
    }
    self.mbtiView = mbtiView
  }
}

extension OnboardingProfileView {
  public func updateTitleTextView(_ type: ProfileType, nickName: String = "") {
    titleTextView.updateTitleLabels(type, nickName: nickName)
    warningLabel.text = type.warningDescription
    
    switch type {
    case .gender:
      setupGenderCheckBoxView()
      bindGender()
    case .birth:
      setupDatePicker()
      bindBirth()
    case .mbti:
      setupMBTIView()
      bindMBTI()
    case .profileImage:
      setupProfileImagePicker()
      bindProfileImage()
    case .none, .nickName:
      print("none")
    }
  }
  
  public func setGender(_ gender: Gender) {
    maleCheckBoxView?.updateForCurrentState(gender)
    femaleCheckBoxView?.updateForCurrentState(gender)
  }
  
  public func updateContinuBtn(_ state: Bool) {
    if state {
      continueButton.currentState = .enabled
    } else {
      continueButton.currentState = .disabled
    }
  }
  
  public func updateMBTIView(_ mbti: MBTI) {
    mbtiView?.updateMBTIView(mbti)
  }
}
