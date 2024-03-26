//
//  EditGenderView.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

import DomainLiveInterface

final class EditGenderView: BaseView, Touchable {
  
  var gender: MatchGender = .all {
    didSet {
      genderButton.setImage(gender)
      genderLabel.text = gender.text
    }
  }
  
  // MARK: - View Property
  private let genderButton: EditGenderButton = EditGenderButton().then {
    typealias Configuration = EditGenderButton.Configuration
    let selected = Configuration(
      backgroundColor: SystemColor.primaryLight.uiColor,
      borderColor: SystemColor.primaryStroke.uiColor,
      isEnabled: false
    )
    let deselected = Configuration(
      backgroundColor: SystemColor.gray100.uiColor,
      borderColor: SystemColor.gray100.uiColor,
      isEnabled: true
    )
    $0.setState(selected, for: .selected)
    $0.setState(deselected, for: .deselected)
    $0.currentState = .deselected
    
    let width = (CGRect.appFrame.width - 88) / 3
    $0.layer.cornerRadius = width / 2
  }
  
  private let genderLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
    $0.textColor = SystemColor.gray600.uiColor
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  var touchEventRelay: PublishRelay<Void> = .init()
  
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setGenderButton()
    setGenderLabel()
  }
  
  // MARK: - UIBindable
  override func bind() {
    genderButton.touchEventRelay
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension EditGenderView {
  private func setGenderButton() {
    let viewFrame: CGRect = .appFrame
    let buttonWidth = viewFrame.width - 88 / 3
    
    addSubview(genderButton)
    genderButton.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.width.height.equalTo(buttonWidth)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func setGenderLabel() {
    addSubview(genderLabel)
    genderLabel.snp.makeConstraints {
      $0.top.equalTo(genderButton.snp.bottom).offset(12)
      $0.height.equalTo(19)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}

extension EditGenderView {
  func setButtonState(_ gender: MatchGender) {
    genderButton.currentState = self.gender == gender ? .selected : .deselected
  }
}
