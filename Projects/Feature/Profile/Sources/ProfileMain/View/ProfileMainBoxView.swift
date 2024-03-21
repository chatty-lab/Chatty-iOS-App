//
//  ProfileMainBoxView.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/17/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

final class ProfileMainBoxView: BaseView, Touchable {
  // MARK: - View Property
  private let percentLabel: UILabel = UILabel().then {
    $0.backgroundColor = SystemColor.primaryNormal.uiColor
    $0.textColor = SystemColor.basicWhite.uiColor
    $0.font = SystemFont.body01.font
    $0.textAlignment = .center
    
    $0.layer.cornerRadius = 15
    $0.clipsToBounds = true
    $0.text = "20% 완성"
  }
  
  private let profileImageView: UIView = UIView().then {
    $0.contentMode = .scaleAspectFit
    $0.layer.cornerRadius = 148 / 2
    $0.layer.borderWidth = 2
    $0.layer.borderColor = SystemColor.basicBlack.uiColor.cgColor
    $0.backgroundColor = .lightGray
  }
  
  private let editProfileButton: ChangeableImageButton = ChangeableImageButton().then {
    typealias Configuration = ChangeableImageButton.Configuration
    let commonState = Configuration(
      image: Images.pen.image,
      tintColor: SystemColor.primaryNormal.uiColor,
      backgroundColor: SystemColor.basicWhite.uiColor,
      size: 24,
      isEnabled: true
    )
    $0.setState(commonState, for: .customImage)
    $0.currentState = .customImage
    
    $0.layer.cornerRadius = 36 / 2
    $0.layer.borderColor = SystemColor.gray200.uiColor.cgColor
    $0.layer.borderWidth = 2
  }

  private let nicknameLabel: UILabel = UILabel().then {
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.title02.font
  }
  

  private let ageAndGenderLabel: UILabel = UILabel().then {
    $0.textColor = SystemColor.gray700.uiColor
    $0.font = SystemFont.body01.font
  }

  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  var touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setupProfileBoxItemView()
  }
  
  // MARK: - UIBindable
  override func bind() {
    editProfileButton.touchEventRelay
      .map { _ in TouchEventType.editProfile }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension ProfileMainBoxView {
  enum TouchEventType {
    case editProfile
  }
}

extension ProfileMainBoxView {
  private func setupProfileBoxItemView() {
    addSubview(profileImageView)
    addSubview(percentLabel)
    addSubview(editProfileButton)
    
    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(72)
      $0.height.width.equalTo(148)
      $0.centerX.equalToSuperview()
    }
    
    percentLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.top).offset(-20)
      $0.height.equalTo(33)
      $0.width.equalTo(90)
      $0.centerX.equalToSuperview()
    }
    
    editProfileButton.snp.makeConstraints {
      $0.size.equalTo(36)
      $0.trailing.bottom.equalTo(profileImageView)
    }
    
  }
}
