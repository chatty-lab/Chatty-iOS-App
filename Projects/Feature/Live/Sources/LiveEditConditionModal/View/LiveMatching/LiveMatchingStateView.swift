//
//  MatchingStateView.swift
//  FeatureLive
//
//  Created by 윤지호 on 3/15/24.
//

import UIKit
import RxSwift
import RxCocoa
import SharedDesignSystem
import SnapKit
import Then

final class LiveMatchingStateView: BaseView {
  // MARK: - View Property
  private let imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  private let ticketTypeLabel: UILabel = UILabel().then {
    $0.font = SystemFont.caption01.font
    $0.textColor = SystemColor.gray600.uiColor
  }
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setupView()
  }
}

extension LiveMatchingStateView {
  private func setupView() {
    self.backgroundColor = SystemColor.gray200.uiColor
    self.layer.cornerRadius = 204 / 2
    
    self.addSubview(titleLabel)
    self.addSubview(imageView)
    self.addSubview(ticketTypeLabel)
    
    titleLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.height.equalTo(19)
    }
    
    imageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.size.equalTo(32)
      $0.bottom.equalTo(titleLabel.snp.top).offset(-8)
    }
    
    ticketTypeLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.height.equalTo(16)
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
    }
  }
}

extension LiveMatchingStateView {
  func setData(_ type: MatchMode) {
    switch type {
    case .nomalMode:
      imageView.image = Images.magnifyingGlassTiltedLeft.image
      titleLabel.text = "기본 모드"
      ticketTypeLabel.text = "FREE"
    case .fastMode:
      imageView.image = Images.highVoltage.image
      titleLabel.text = "빠른 모드"
      ticketTypeLabel.text = "FREE"
    }
  }
}
