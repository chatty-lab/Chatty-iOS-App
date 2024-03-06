//
//  ProfileAuthenticationToggleView.swift
//  FeatureLive
//
//  Created by 윤지호 on 3/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

final class ProfileAuthenticationToggleView: BaseView, Touchable {
  // MARK: - View Property
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "프로필 인증 친구만 연결하기"
    $0.font = SystemFont.body01.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  private let toggleSwitch: UISwitch = UISwitch().then {
    $0.onTintColor = SystemColor.primaryNormal.uiColor
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  var touchEventRelay: PublishRelay<Bool> = .init()
  
  // MARK: - UIConfigurable
  override func configureUI() {
    backgroundColor = SystemColor.gray100.uiColor
    layer.cornerRadius = 8
    setupTitle()
    setupToggleSwitch()
  }
  
  // MARK: - UIBindable
  override func bind() {
    toggleSwitch.rx.isOn
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension ProfileAuthenticationToggleView {
  private func setupTitle() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(19)
      $0.height.equalTo(17)
      $0.centerY.equalToSuperview()
    }
  }
  
  private func setupToggleSwitch() {
    addSubview(toggleSwitch)
    toggleSwitch.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(16)
      $0.size.equalTo(40)
      $0.centerY.equalToSuperview()
    }
  }
}

