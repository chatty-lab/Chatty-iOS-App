//
//  MatchModeButton.swift
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

final class MatchModeButton: UIControl, Touchable, Highlightable {
  // MARK: - View Property
  private let imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  private let subtitleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.body01.font
    $0.textColor = SystemColor.gray600.uiColor
  }
  
  private let ticketCountImageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let ticketCountLabel: UILabel = UILabel().then {
    $0.font = SystemFont.caption01.font
    $0.textColor = SystemColor.gray600.uiColor

  }
  
  // MARK: - Rx Property
  let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let touchEventRelay = PublishRelay<Void>()
  
  // MARK: - Initialize Method
  required init() {
    super.init(frame: .init())
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MatchModeButton {
  private func bind() {
    self.rx.controlEvent(.touchDown)
      .bind(with: self) { owner, _ in
        owner.highlight(owner)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
      self.rx.controlEvent(.touchDragExit).map { _ in Void() },
      self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { owner, _ in
      owner.unhighlight(owner)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .map { _ in Void() }
      .withUnretained(self)
      .do { owner, _ in
        self.unhighlight(owner)
      }
      .map { _ in Void() }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    backgroundColor = SystemColor.gray100.uiColor
    layer.cornerRadius = 16
    
    addSubview(titleLabel)
    addSubview(imageView)
    addSubview(subtitleLabel)
    addSubview(ticketCountLabel)
    
    titleLabel.snp.makeConstraints {
      $0.height.equalTo(19)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
    
    imageView.snp.makeConstraints {
      $0.size.equalTo(32)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(titleLabel.snp.top).offset(-14)
    }
    
    subtitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(-4)
      $0.height.equalTo(19)
      $0.centerX.equalToSuperview()
    }
    
    ticketCountLabel.snp.makeConstraints {
      $0.top.equalTo(subtitleLabel.snp.bottom).offset(-4)
      $0.height.equalTo(19)
      $0.centerX.equalToSuperview()
    }
  }
}

extension MatchModeButton {
  func setButtonType(_ type: MatchMode) {
    switch type {
    case .nomalMode:
      imageView.image = Images.magnifyingGlassTiltedLeft.image
      titleLabel.text = "기본 모드"
      subtitleLabel.text = "기본 추천 매칭"
      ticketCountLabel.text = "FREE"
    case .fastMode:
      imageView.image = Images.highVoltage.image
      titleLabel.text = "빠른 모드"
      subtitleLabel.text = "일반보다 빠른 매칭"
      ticketCountLabel.text = "FREE"
    }
  }
}
