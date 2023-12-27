//
//  OnboardingView.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import SnapKit
import Then
import SharedDesignSystem

protocol OnboardingRootViewDelegate: AnyObject {
  func didTapSignUp()
  func didTapSignIn()
}

final class OnboardingRootView: UIView {
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
    $0.textColor = UIColor(asset: Colors.basicBlack)
    $0.font = Font.Pretendard(.Bold).of(size: 26)
    $0.textAlignment = .center
    $0.sizeToFit()
  }
  
  private let welcomeSubTitleLabel: UILabel = UILabel().then {
    $0.text = "새로운 친구들이 여러분을 기다리고 있어요."
    $0.textColor = UIColor(asset: Colors.basicBlack)
    $0.font = Font.Pretendard(.Regular).of(size: 16)
    $0.textAlignment = .center
    $0.sizeToFit()
  }
  
  private lazy var signUpButton: UIButton = UIButton().then {
    var container = AttributeContainer()
    container.font = Font.Pretendard(.SemiBold).of(size: 16)
    container.foregroundColor = UIColor(asset: Colors.basicWhite)
    
    var configuration = UIButton.Configuration.filled()
    configuration.attributedTitle = .init("시작하기", attributes: container)
    configuration.baseBackgroundColor = UIColor(asset: Colors.primaryNormal)
    configuration.titleAlignment = .center
    
    $0.configuration = configuration
    $0.layer.cornerRadius = 6
    $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
  }
  
  private lazy var signInButton: UILabel = UILabel().then {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInButtonTapped))
    let attributedString = NSMutableAttributedString(string: "이미 계정이 있다면? 로그인")
    let loginRange = (attributedString.string as NSString).range(of: "로그인")
    
    attributedString.addAttribute(
      .font,
      value: Font.Pretendard(.SemiBold).of(size: 13),
      range: NSRange(
        location: 0,
        length: attributedString.length
      )
    )
    attributedString.addAttribute(
      .foregroundColor,
      value: UIColor(asset: Colors.gray600)!,
      range: NSRange(
        location: 0,
        length: attributedString.length
      )
    )
    attributedString.addAttribute(
      .foregroundColor,
      value: UIColor(asset: Colors.primaryNormal)!,
      range: loginRange
    )
    
    $0.attributedText = attributedString
    $0.addGestureRecognizer(tapGesture)
    $0.isUserInteractionEnabled = true
  }
  
  // MARK: - Life Method
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Delegate
  
  weak var delegate: OnboardingRootViewDelegate?
}

// MARK: - UI setup
extension OnboardingRootView {
  private func configureUI() {
    setupWelcomeBox()
    setupSignInButton()
    setupSignUpButton()
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

// MARK: Action
extension OnboardingRootView {
  @objc func signUpButtonTapped() {
    delegate?.didTapSignUp()
  }
  
  @objc func signInButtonTapped() {
    delegate?.didTapSignIn()
  }
}
