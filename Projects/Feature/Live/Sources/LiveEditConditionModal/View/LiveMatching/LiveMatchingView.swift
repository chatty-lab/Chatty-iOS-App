//
//  LiveMatchingView.swift
//  FeatureLive
//
//  Created by 윤지호 on 3/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SharedDesignSystem
import SnapKit
import Then

final class LiveMatchingView: BaseView {
  // MARK: - View Property
  private let cancelButton: CancelButton = CancelButton()
  
  private let conditionLabel: UILabel = UILabel().then {
    $0.font = SystemFont.body02.font
    $0.textColor = SystemColor.gray600.uiColor
  }
  
  private let matchingImageView: UIView = UIView().then {
    $0.backgroundColor = SystemColor.gray200.uiColor
    $0.layer.cornerRadius = 204 / 2
  }
  
  private let matchingStateLabel: UILabel = UILabel().then {
    $0.font = SystemFont.headLine02.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  private let warningLabel: UILabel = UILabel().then {
    $0.text = "대기 중 앱 밖으로 나가면 종료되니 주의해 주세요."
    $0.font = SystemFont.caption02.font
    $0.textColor = SystemColor.gray600.uiColor
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setupCancelButton()
    setupMatchingViews()
    setupWarningLabel()
  }
  
  // MARK: - UIBindable
  override func bind() {
    cancelButton.touchEventRelay
      .map { _ in TouchEventType.cancel }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension LiveMatchingView: Touchable {
  enum TouchEventType {
    case cancel
  }
}

extension LiveMatchingView {
  private func setupCancelButton() {
    addSubview(cancelButton)
    cancelButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(58)
      $0.height.width.equalTo(24)
      $0.leading.equalToSuperview().inset(16)
    }
  }
  
  private func setupMatchingViews() {
    addSubview(matchingImageView)
    addSubview(matchingStateLabel)
    addSubview(conditionLabel)
    
    matchingImageView.snp.makeConstraints {
      $0.height.width.equalTo(204)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-4)
    }
    
    matchingStateLabel.snp.makeConstraints {
      $0.height.equalTo(29)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(matchingImageView.snp.top).offset(-69)
    }
    
    conditionLabel.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(matchingStateLabel.snp.top).offset(-4)
    }
  }
  
  private func setupWarningLabel() {
    addSubview(warningLabel)
    warningLabel.snp.makeConstraints {
      $0.height.equalTo(18)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().inset(50)
    }
  }
}

extension LiveMatchingView {
  func setMatchingState(_ state: MatchingState) {
    matchingStateLabel.text = state.stateText
  }
  
  func setCondition(_ condition: MatchConditionState) {
    conditionLabel.text = "\(condition.gender.text) ・ \(condition.ageRange.toTilde)세"
  }
}
