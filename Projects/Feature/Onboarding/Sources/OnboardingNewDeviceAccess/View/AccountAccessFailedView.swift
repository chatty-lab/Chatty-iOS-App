//
//  AccountAccessFailedView.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import SharedDesignSystem

final class AccountAccessFailedView: BaseView, Touchable {
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "인증에 실패했어요"
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.headLine01.font
  }
  
  private lazy var subTitleLabel: UILabel = UILabel().then {
    $0.text = subTitleValue
    $0.font = SystemFont.title04.font
    $0.textColor = SystemColor.gray700.uiColor
  }
  
  private lazy var bottomActionButton: FillButton = FillButton().then {
    typealias Config = FillButton.Configuration
    let config = Config(backgroundColor: SystemColor.primaryNormal.uiColor, isEnabled: true)
    
    $0.title = bottomActionButtonTitleValue
    $0.setState(config, for: .enabled)
    $0.currentState = .enabled
    $0.layer.cornerRadius = 8
  }
  
  var subTitleValue: String {
    switch failedType {
    case .locked:
      return "3일 뒤 다시 시도하거나 새 계정을 만들어주세요"
    case .unlocked:
      return "마지막으로 한 번 더 시도할 수 있어요"
    }
  }
  
  var bottomActionButtonTitleValue: String {
    switch failedType {
    case .unlocked:
      return "다시 답변하기"
    case .locked:
      return "닫기"
    }
  }
  
  let failedType: AccountAccessFailedType
  
  var touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(failedType: AccountAccessFailedType) {
    self.failedType = failedType
    super.init(frame: .zero)
  }
  
  override func configureUI() {
    setupTitleLabel()
    setupSubTitleLabel()
    setupBottomActionButton()
  }
  
  override func bind() {
    bottomActionButton.touchEventRelay
      .bind(with: self) { owner, _ in
        switch owner.failedType {
        case .locked:
          owner.touchEventRelay.accept(.done)
        case .unlocked:
          owner.touchEventRelay.accept(.retry)
        }
      }
      .disposed(by: disposeBag)
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(16)
      $0.horizontalEdges.equalToSuperview().inset(20)
    }
  }
  
  private func setupSubTitleLabel() {
    addSubview(subTitleLabel)
    subTitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.horizontalEdges.equalToSuperview().inset(20)
    }
  }
  
  private func setupBottomActionButton() {
    addSubview(bottomActionButton)
    bottomActionButton.snp.makeConstraints {
      $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(52)
    }
  }
}

extension AccountAccessFailedView {
  public enum TouchEventType {
    case retry
    case done
    case email
  }
}
