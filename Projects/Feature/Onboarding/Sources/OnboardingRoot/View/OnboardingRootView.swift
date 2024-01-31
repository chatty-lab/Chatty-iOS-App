//
//  OnboardingView.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
import Then
import SharedDesignSystem

final class OnboardingRootView: BaseView, Touchable {
  // MARK: - View
  private let containerView: UIView = UIView()
  
  private let logoImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(asset: Images.chattyLogo)
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 24
    $0.clipsToBounds = true
  }
  
  private let welcomeTitleLabel: UILabel = UILabel().then {
    $0.text = "반가워요!"
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.headLine01.font
    $0.textAlignment = .center
    $0.sizeToFit()
  }
  
  private let welcomeSubTitleLabel: UILabel = UILabel().then {
    $0.text = "새로운 친구들이 여러분을 기다리고 있어요."
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.title04.font
    $0.textAlignment = .center
    $0.sizeToFit()
  }
  
  private let signUpButton: FillButton = FillButton().then {
    typealias Configuration = FillButton.Configuration
    let enabledConfig = Configuration(backgroundColor: SystemColor.primaryNormal.uiColor, isEnabled: true)
    
    $0.title = "시작하기"
    $0.cornerRadius = 8
    $0.setState(enabledConfig, for: .enabled)
    $0.currentState = .enabled
  }
  
  private let signInButton: UILabel = UILabel().then {
    let attributedString = NSMutableAttributedString(string: "이미 계정이 있다면? 로그인")
    let loginRange = (attributedString.string as NSString).range(of: "로그인")
    
    attributedString.addAttribute(
      .font,
      value: Font.Pretendard(.Regular).of(size: 13),
      range: NSRange(
        location: 0,
        length: attributedString.length
      )
    )
    attributedString.addAttribute(
      .foregroundColor,
      value: SystemColor.gray600.uiColor,
      range: NSRange(
        location: 0,
        length: attributedString.length
      )
    )
    attributedString.addAttribute(
      .foregroundColor,
      value: SystemColor.primaryNormal.uiColor,
      range: loginRange
    )
    
    $0.attributedText = attributedString
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable
  var touchEventRelay: RxRelay.PublishRelay<TouchEventType> = .init()
  
  // MARK: - Life Method
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setupWelcomeBox()
    setupSignInButton()
    setupSignUpButton()
  }
  
  // MARK: - UIBindable
  override func bind() {
    signUpButton.touchEventRelay
      .map{ .signUp }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    signInButton.rx.tapGesture()
      .map{ _ in .signIn }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension OnboardingRootView {
  enum TouchEventType {
    case signUp
    case signIn
  }

  private func setupWelcomeBox() {
    addSubview(containerView)
    containerView.addSubview(logoImageView)
    containerView.addSubview(welcomeTitleLabel)
    containerView.addSubview(welcomeSubTitleLabel)
    
    containerView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
    }
    
    logoImageView.snp.makeConstraints {
      $0.width.height.equalTo(124)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview()
    }
    
    welcomeTitleLabel.snp.makeConstraints {
      $0.top.equalTo(logoImageView.snp.bottom).offset(42)
      $0.centerX.equalToSuperview()
    }
    
    welcomeSubTitleLabel.snp.makeConstraints {
      $0.top.equalTo(welcomeTitleLabel.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setupSignUpButton() {
    addSubview(signUpButton)
    signUpButton.snp.makeConstraints {
      $0.bottom.equalTo(signInButton.snp.top).offset(-20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(52)
    }
  }
  
  private func setupSignInButton() {
    addSubview(signInButton)
    signInButton.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-13)
      $0.centerX.equalToSuperview()
    }
  }
}
