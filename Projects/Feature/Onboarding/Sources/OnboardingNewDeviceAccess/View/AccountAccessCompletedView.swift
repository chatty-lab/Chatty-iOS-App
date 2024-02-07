//
//  AccountAccessCompletedView.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 1/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import SharedDesignSystem

final class AccountAccessCompletedView: BaseView, Touchable {
  // MARK: - View Property
  private let profileImageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = SystemColor.gray700.uiColor
  }
  
  private lazy var titleLabel: UILabel = UILabel().then {
    $0.text = "윤둥뚱차님 돌아왔군요!"
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.title02.font
  }
  
  private let subTitleLabel: UILabel = UILabel().then {
    $0.text = "새로운 친구들이 기다리고 있어요"
    $0.textColor = SystemColor.gray600.uiColor
    $0.font = SystemFont.caption02.font
  }
  
  private let continueButton: FillButton = FillButton().then {
    typealias Config = FillButton.Configuration
    let config = Config(backgroundColor: SystemColor.primaryNormal.uiColor, isEnabled: true)
    
    $0.title = "시작하기"
    $0.setState(config, for: .enabled)
    $0.currentState = .enabled
    $0.layer.cornerRadius = 8
  }
  
  // MARK: - Touchable
  public var touchEventRelay: PublishRelay<Void> = .init()
  
  override func configureUI() {
    setupProfileImageView()
    setupTitleLabel()
    setupSubTitleLabel()
    setupContinueButton()
  }
  
  private func setupProfileImageView() {
    addSubview(profileImageView)
    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(80)
      $0.centerX.equalToSuperview()
      $0.size.equalTo(160)
    }
    profileImageView.makeCircle(with: 160)
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func setupSubTitleLabel() {
    addSubview(subTitleLabel)
    subTitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func setupContinueButton() {
    addSubview(continueButton)
    continueButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-16)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(52)
    }
  }
}
