//
//  MatchBoxView.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/28/24.
//

import UIKit
import SharedDesignSystem
import RxSwift
import RxCocoa
import SnapKit
import Then

final class MatchBoxView: BaseView {
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "어떤 친구와 대화할까요?"
    $0.font = SystemFont.title02.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  private let conditionView = UIView().then {
    $0.backgroundColor = .cyan
  }
  
  private let genderConditionButton: MatchConditionButton = MatchConditionButton().then {
    $0.setImage(MatchGender.all.image)
    $0.setLabelText(MatchGender.all.text)
  }
  
  private let ageConditionButton: MatchConditionButton = MatchConditionButton().then {
    $0.setImage(Images.birthdayCake.image)
    $0.setLabelText("20 - 30")
  }
  
  private let talkButton: FillButton = FillButton().then {
    $0.title = "대화하기"
    typealias Configuration = FillButton.Configuration
    let enabledConfig = Configuration(
      backgroundColor: SystemColor.primaryNormal.uiColor,
      isEnabled: true
    )
    $0.setState(enabledConfig, for: .enabled)
    $0.currentState = .enabled
    $0.cornerRadius = 68 / 2
  }
  
  private let disposeBag = DisposeBag()
  
  var touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  override func configureUI() {
    super.configureUI()
    setupView()
    setupTitleLabel()
    setupConditionButtons()
    setupTalkButton()
  }
  
  // MARK: - UIBindable
  override func bind() {
    super.bind()
    
    genderConditionButton.touchEventRelay
      .map { _ in TouchEventType.genderCondition }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    ageConditionButton.touchEventRelay
      .map { _ in TouchEventType.ageCondition }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    talkButton.touchEventRelay
      .map { _ in TouchEventType.talkButton }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
}

extension MatchBoxView: Touchable {
  enum TouchEventType {
    case genderCondition
    case ageCondition
    case talkButton
  }
}

extension MatchBoxView {
  private func setupView() {
    self.backgroundColor = .white
    self.setRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
    self.addShadow(location: .top)
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(36)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(22)
    }
  }
  
  private func setupConditionButtons() {
    addSubview(genderConditionButton)
    genderConditionButton.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(24)
      $0.leading.equalToSuperview().inset(20)
      $0.height.equalTo(108)
      $0.width.equalToSuperview().dividedBy(2).inset(15)
    }
    
    addSubview(ageConditionButton)
    ageConditionButton.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(24)
      $0.leading.equalTo(genderConditionButton.snp.trailing).offset(20)
      $0.height.equalTo(108)
      $0.width.equalToSuperview().dividedBy(2).inset(15)
    }
  }
  
  private func setupTalkButton() {
    addSubview(talkButton)
    talkButton.snp.makeConstraints {
      $0.top.equalTo(genderConditionButton.snp.bottom).offset(24)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(68)
      $0.bottom.equalToSuperview().inset(32)
    }
  }
}

extension MatchBoxView {
  func setGenderCondition(_ gender: MatchGender) {
    genderConditionButton.setImage(gender.image)
    genderConditionButton.setLabelText(gender.text)
  }
  
  func setAgeCondition(_ age: String) {
    ageConditionButton.setLabelText(age)
  }
}
