//
//  EditAgeRangeSlider.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import SharedDesignSystem
import DoubleSlider
import DomainLiveInterface

final class EditAgeRangeSliderView: BaseView, Touchable {
  // MARK: - View Property
  private let ageRangeSlider: DoubleSlider = DoubleSlider()
  
  private let selectAllButton: FillButton = FillButton(horizontalInset: 0).then {
    typealias Configuration = FillButton.Configuration
    let enabled = Configuration(
      backgroundColor: .clear,
      textColor: SystemColor.primaryNormal.uiColor,
      isEnabled: true,
      font: SystemFont.caption01.font
    )
    $0.title = "누구나"
    $0.setState(enabled, for: .enabled)
    $0.currentState = .enabled
  }
  
  private let resetButton: FillButton = FillButton(horizontalInset: 0).then {
    typealias Configuration = FillButton.Configuration
    let enabled = Configuration(
      backgroundColor: .clear,
      textColor: SystemColor.gray600.uiColor,
      isEnabled: true,
      font: SystemFont.body01.font
    )
    $0.title = "초기화"
    $0.setState(enabled, for: .enabled)
    $0.currentState = .enabled
  }
  
  private let rangeLabels: [String] = ["20", "25", "30", "35", "40+"]
  
  private var lowerValue: Double = 0.0
  private var upperValue: Double = 1.0
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touch Property
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setSlider()
    setRangeLabel()
    setButtons()
  }
  
  // MARK: - UIBindable
  override func bind() {
    selectAllButton.touchEventRelay
      .map { _ in
        let range = MatchAgeRange(
          startAge: 20,
          endAge: 40
        )
        return TouchEventType.setAgeRange(range)
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    resetButton.touchEventRelay
      .map { TouchEventType.resetRange }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
}

extension EditAgeRangeSliderView {
  enum TouchEventType {
    case setAgeRange(MatchAgeRange)
    case resetRange
  }
}

extension EditAgeRangeSliderView {
  private func setSlider() {
    ageRangeSlider.editingDidEndDelegate = self
    
    ageRangeSlider.numberOfSteps = rangeLabels.count
    ageRangeSlider.smoothStepping = true
    
    ageRangeSlider.labelsAreHidden = true
    
    ageRangeSlider.lowerValueStepIndex = 0
    ageRangeSlider.upperValueStepIndex = rangeLabels.count - 1
    
    ageRangeSlider.trackTintColor = SystemColor.gray300.uiColor
    ageRangeSlider.trackHighlightTintColor = SystemColor.primaryNormal.uiColor
    
    ageRangeSlider.layerInset = 8
    
    let superViewFrame = Int(CGRect.appFrame.width - 20)
    addSubview(ageRangeSlider)
    ageRangeSlider.snp.makeConstraints {
      $0.top.equalToSuperview().offset(-10)
      $0.height.equalTo(40)
      $0.width.equalTo(superViewFrame)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func setRangeLabel() {
    let labels: [UILabel] = rangeLabels.map { text in
      let label = UILabel()
      label.text = text
      label.textColor = SystemColor.gray600.uiColor
      label.font = SystemFont.caption02.font
      return label
    }
    
    for (index ,label) in labels.enumerated() {
      ageRangeSlider.addSubview(label)
      
      let superViewFrame = Int(CGRect.appFrame.width - 60)
      var centerX = 0
      
      switch index {
      case 0:
        centerX = (superViewFrame / 4) * -2
      case 1:
        centerX = (superViewFrame / 4) * -1
      case 2:
        centerX = 0
      case 3:
        centerX = (superViewFrame / 4) * 1
      default:
        centerX = (superViewFrame / 4) * 2
      }
      
      label.snp.makeConstraints {
        $0.top.equalTo(ageRangeSlider.snp.bottom).offset(4)
        $0.centerX.equalToSuperview().offset(centerX)
        $0.height.equalTo(18)
      }
      switch index {
      case 0:
        print("")

      default:
        print("")
      }
    }
    
  }
  
  private func setButtons() {
    addSubview(selectAllButton)
    addSubview(resetButton)
    
    selectAllButton.snp.makeConstraints {
      $0.top.equalTo(ageRangeSlider.snp.bottom).offset(42)
      $0.height.equalTo(17)
      $0.leading.equalToSuperview().inset(20)

    }
    
    resetButton.snp.makeConstraints {
      $0.top.equalTo(ageRangeSlider.snp.bottom).offset(42)
      $0.height.equalTo(17)
      $0.trailing.equalToSuperview().inset(20)
    }
  }
}

extension EditAgeRangeSliderView: DoubleSliderEditingDidEndDelegate {
  func editingDidEnd(for doubleSlider: DoubleSlider) {
    switch doubleSlider.lowerValueStepIndex {
    case 0:
      doubleSlider.lowerValue = 0
    case 1:
      doubleSlider.lowerValue = 1 / 4 * 1
    case 2:
      doubleSlider.lowerValue = 1 / 4 * 2
    case 3:
      doubleSlider.lowerValue = 1 / 4 * 3
    default:
      doubleSlider.lowerValue = 0
    }
    
    switch doubleSlider.upperValueStepIndex {
    case 1:
      doubleSlider.upperValue = 1 / 4 * 1
    case 2:
      doubleSlider.upperValue = 1 / 4 * 2
    case 3:
      doubleSlider.upperValue = 1 / 4 * 3
    case 4:
      doubleSlider.upperValue = 1
    default:
      doubleSlider.upperValue = 1
    }
    
    if doubleSlider.lowerValue != self.lowerValue {
      self.lowerValue = doubleSlider.lowerValue
      let range = MatchAgeRange(
        startAge: labelValue(lowerValue),
        endAge: labelValue(upperValue)
      )
      self.touchEventRelay.accept(.setAgeRange(range))
    }
    
    if doubleSlider.upperValue != self.upperValue {
      self.upperValue = doubleSlider.upperValue
      let range = MatchAgeRange(
        startAge: labelValue(lowerValue),
        endAge: labelValue(upperValue)
      )
      self.touchEventRelay.accept(.setAgeRange(range))
    }
  }
  
  private func labelValue(_ value: Double) -> Int {
    switch value {
    case 0.0:
      return 20
    case 0.25:
      return 25
    case 0.5:
      return 30
    case 0.75:
      return 35
    default:
      return 40
    }
  }
  
  private func sliderValue(_ value: Int) -> Double {
    switch value {
    case 20:
      return 0.0
    case 25:
      return 0.25
    case 30:
      return 0.5
    case 35:
      return 0.75
    default:
      return 1
    }
  }
  
  func setAgeCondition(_ ageRange: MatchAgeRange) {
    let startAge = sliderValue(ageRange.startAge)
    let endAge = sliderValue(ageRange.endAge)
    
    self.lowerValue = startAge
    self.upperValue = endAge
    
    self.ageRangeSlider.lowerValue = startAge
    self.ageRangeSlider.upperValue = endAge
  }
}
