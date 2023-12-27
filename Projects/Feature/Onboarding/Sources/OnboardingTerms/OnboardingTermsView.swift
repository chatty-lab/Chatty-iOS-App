//
//  OnboardingTermsView.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import SnapKit
import Then
import SharedDesignSystem

protocol OnboardingTermsViewDelegate: AnyObject {
  func didTapContinue()
}

final class OnboardingTermsView: UIView {
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "채티를 이용하려면 동의가 필요해요"
    $0.font = Font.Pretendard(.SemiBold).of(size: 18)
    $0.textColor = UIColor(asset: Colors.basicBlack)
    $0.textAlignment = .center
  }
  
  private let termOfService: UIView = TermsCheckBoxView().then {
    $0.term = Term(
      type: .termsOfService,
      isRequired: true
    )
  }
  private let privacyPolicy: UIView = TermsCheckBoxView().then {
    $0.term = Term(
      type: .privacyPolicy,
      isRequired: true
    )
  }
  private let locationDataUsage: UIView = TermsCheckBoxView().then {
    $0.term = Term(
      type: .locationDataUsage,
      isRequired: false
    )
  }
  
  private let termContainer: UIView = UIView()
  private let acceptAllButtonView: UIView = UIView().then {
    $0.layer.cornerRadius = 8
    $0.layer.borderColor = UIColor(asset: Colors.gray200)?.cgColor
    $0.layer.borderWidth = 0.7
  }
  private let acceptAllLabel: UILabel = UILabel().then {
    $0.text = "전체 동의"
    $0.textColor = UIColor(asset: Colors.basicBlack)
    $0.font = Font.Pretendard(.Regular).of(size: 14)
  }
  private let checkBoxImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(systemName: "checkmark.circle.fill")
    $0.contentMode = .scaleAspectFill
    $0.tintColor = UIColor(asset: Colors.gray300)
  }
  private lazy var continueButton: RoundButton = RoundButton(text: "시작하기").then {
    $0.delegate = self
  }
  
  weak var delegate: OnboardingTermsViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension OnboardingTermsView {
  private func configureUI() {
    setupTitleView()
    setupTermContainer()
    setupAcceptAllButtonView()
    setupContinueButton()
  }
  
  private func setupTitleView() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(28)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func setupTermContainer() {
    addSubview(termContainer)
    termContainer.addSubview(termOfService)
    termContainer.addSubview(privacyPolicy)
    termContainer.addSubview(locationDataUsage)
    
    termOfService.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    privacyPolicy.snp.makeConstraints {
      $0.top.equalTo(termOfService.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    locationDataUsage.snp.makeConstraints {
      $0.top.equalTo(privacyPolicy.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    termContainer.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(34)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
  }
  
  private func setupAcceptAllButtonView() {
    addSubview(acceptAllButtonView)
    acceptAllButtonView.addSubview(acceptAllLabel)
    acceptAllButtonView.addSubview(checkBoxImageView)
    
    acceptAllButtonView.snp.makeConstraints {
      $0.top.equalTo(termContainer.snp.bottom).offset(30)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(46)
    }
    
    acceptAllLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(18)
      $0.centerY.equalToSuperview()
    }
    
    checkBoxImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-18)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(19)
    }
  }
  
  private func setupContinueButton() {
    addSubview(continueButton)
    
    continueButton.snp.makeConstraints {
      $0.top.equalTo(acceptAllButtonView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(52)
    }
  }
}

extension OnboardingTermsView: RoundButtonDelegate {
  func didTapped() {
    delegate?.didTapContinue()
  }
}
