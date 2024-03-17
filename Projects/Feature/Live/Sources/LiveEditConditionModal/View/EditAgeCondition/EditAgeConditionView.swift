//
//  EditAgeConditionView.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import SharedDesignSystem
import DoubleSlider

import DomainLiveInterface

final class EditAgeConditionView: BaseView {
  // MARK: - View Property
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "나이 선택"
    $0.font = SystemFont.title02.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
    
  private let cancelButton: CancelButton = CancelButton()
  
//  private let ageRangeSlider: EditAgeRangeSliderView = EditAgeRangeSliderView().then {
//    $0.backgroundColor = .green
//  }
  
  private var ageRangeSlider: DoubleSlider = DoubleSlider(frame: .init(x: 30, y: 30, width: 200, height: 50))
  private var labels: [String] = []
  

  
  private let checkRoundButton: FillButton = FillButton().then {
    typealias Configuration = FillButton.Configuration
    let enaleConfig = Configuration(
      backgroundColor: SystemColor.primaryNormal.uiColor,
      isEnabled: true
    )
    
    $0.title = "확인"
    $0.setState(enaleConfig, for: .enabled)
    $0.currentState = .enabled
    
    $0.layer.cornerRadius = 8
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touch Property
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - Initialize Method
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  // MARK: - UIConfigurable
  override func configureUI() {
    print("frame - \(self.frame)")
    setTitleLabel()
    setCancelButton()
    setAgeRangeSlider()
    setCheckRoundButton()
  }
  
  // MARK: - UIBindable
  override func bind() {
    cancelButton.touchEventRelay
      .map { _ in TouchEventType.cancel }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    
    checkRoundButton.touchEventRelay
      .map { _ in TouchEventType.checkButton }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension EditAgeConditionView: Touchable {
  enum TouchEventType {
    case cancel
    case checkButton
    case selectGender(MatchGender)
  }
}

extension EditAgeConditionView {
  private func setTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(32)
      $0.height.equalTo(22)
      $0.leading.equalToSuperview().inset(20)
    }
  }
  
  private func setCancelButton() {
    addSubview(cancelButton)
    cancelButton.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.height.equalTo(24)
      $0.trailing.equalToSuperview().inset(20)
    }
  }
  
  private func setAgeRangeSlider() {
    for num in stride(from: 20, to: 40, by: 5) {
      labels.append("$\(num)")
    }
    labels.append("No limit")
    
    
    ageRangeSlider.labelDelegate = self

    ageRangeSlider.valueChangedDelegate = self
    ageRangeSlider.editingDidEndDelegate = self
    
    ageRangeSlider.numberOfSteps = labels.count
    ageRangeSlider.smoothStepping = true

    ageRangeSlider.labelsAreHidden = false
    
    ageRangeSlider.lowerLabelMarginOffset = 8.0
    ageRangeSlider.upperLabelMarginOffset = 8.0

    ageRangeSlider.lowerValueStepIndex = 0
    ageRangeSlider.upperValueStepIndex = labels.count - 1
    
    addSubview(ageRangeSlider)
    ageRangeSlider.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(30)
      $0.height.equalTo(50)
      $0.horizontalEdges.equalToSuperview().inset(20)
    }
  }
  
  private func setCheckRoundButton() {
    addSubview(checkRoundButton)
    checkRoundButton.snp.makeConstraints {
      $0.top.equalTo(ageRangeSlider.snp.bottom).offset(137)
      $0.height.equalTo(52)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().inset(28)
    }
  }
  
}

extension EditAgeConditionView {
  func setGenderState(_ gender: MatchGender) {
    
  }
}

extension EditAgeConditionView: DoubleSliderValueChangedDelegate {
  func valueChanged(for doubleSlider: DoubleSlider) {
    print("doubleSlider1 - \(doubleSlider.lowerValue)")
    print("doubleSlider2 - \(doubleSlider.upperValue)")

  }
}

extension EditAgeConditionView: DoubleSliderLabelDelegate {
  func labelForStep(at index: Int) -> String? {
    print("labelForStep - \(index)")
    return "label"
  }
  
  
}

extension EditAgeConditionView: DoubleSliderEditingDidEndDelegate {
  func editingDidEnd(for doubleSlider: DoubleSlider) {
    print("editingDidEnd")
  }
}
