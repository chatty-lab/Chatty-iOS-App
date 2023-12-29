//
//  OnboardingTermsView.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import RxSwift
import RxCocoa
import SharedDesignSystem
import SnapKit
import Then

final class OnboardingTermsView: UIView, Touchable {
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "채티를 이용하려면 동의가 필요해요"
    $0.font = Font.Pretendard(.SemiBold).of(size: 18)
    $0.textColor = UIColor(asset: Colors.basicBlack)
    $0.textAlignment = .center
    $0.sizeToFit()
  }
  
  private let termContainer: UIView = UIView()
  
  private let termOfService: TermsCheckBoxView = TermsCheckBoxView(
    term: Terms(
      type: .termsOfService,
      isRequired: true
    )
  )
  
  private let privacyPolicy: TermsCheckBoxView = TermsCheckBoxView(
    term: Terms(
      type: .privacyPolicy,
      isRequired: true
    )
  )
  
  private let locationDataUsage: TermsCheckBoxView = TermsCheckBoxView(
    term: Terms(
      type: .locationDataUsage,
      isRequired: false
    )
  )
  
  private let allConsentButtonView: AllConsentView = AllConsentView().then {
    typealias Configuration = AllConsentView.Configuration
    let uncheckedConfig = Configuration(tintColor: UIColor(asset: Colors.gray500)!)
    let checkedConfig = Configuration(tintColor: UIColor(asset: Colors.primaryNormal)!)
    
    $0.setState(uncheckedConfig, for: .unChecked)
    $0.setState(checkedConfig, for: .checked)
    $0.currentState = .unChecked
  }
  
  private let advanceButton: RoundButton = RoundButton(text: "시작하기").then {
    typealias Configuration = RoundButton.Configuration
    let enabledConfig = Configuration(backgroundColor: UIColor(asset: Colors.primaryNormal)!, isEnabled: true)
    let disabledConfig = Configuration(backgroundColor: UIColor(asset: Colors.gray300)!, isEnabled: false)
    
    $0.setState(enabledConfig, for: .enabled)
    $0.setState(disabledConfig, for: .disabled)
  }
  
  private let disposeBag = DisposeBag()
  public let didTouch: PublishRelay<TouchType> = .init()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension OnboardingTermsView {
  enum TouchType {
    case advance
    case allConsent
    case consent(Terms)
    case open(Terms)
  }
  
  private func bind() {
    termOfService.didTouch
      .map {
        switch $0 {
        case .open(let terms): return .open(terms)
        case .consent(let terms): return .consent(terms)
        }
      }
      .bind(to: self.didTouch)
      .disposed(by: disposeBag)
    
    privacyPolicy.didTouch
      .map {
        switch $0 {
        case .open(let terms): return .open(terms)
        case .consent(let terms): return .consent(terms)
        }
      }
      .bind(to: self.didTouch)
      .disposed(by: disposeBag)
    
    
    locationDataUsage.didTouch
      .map {
        switch $0 {
        case .open(let terms): return .open(terms)
        case .consent(let terms): return .consent(terms)
        }
      }
      .bind(to: self.didTouch)
      .disposed(by: disposeBag)
    
    allConsentButtonView.rx.tapGesture()
      .when(.recognized)
      .map { _ in .allConsent }
      .bind(to: self.didTouch)
      .disposed(by: disposeBag)
    
    advanceButton.didTouch
      .map { .advance }
      .bind(to: self.didTouch)
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    setupTitleView()
    setupTermContainer()
    setupAllConsentButtonView()
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
      $0.top.equalTo(termOfService.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    locationDataUsage.snp.makeConstraints {
      $0.top.equalTo(privacyPolicy.snp.bottom).offset(8)
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    termContainer.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(24)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
  }
  
  private func setupAllConsentButtonView() {
    addSubview(allConsentButtonView)
    
    allConsentButtonView.snp.makeConstraints {
      $0.top.equalTo(termContainer.snp.bottom).offset(21)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(46)
    }
  }
  
  private func setupContinueButton() {
    addSubview(advanceButton)
    
    advanceButton.snp.makeConstraints {
      $0.top.equalTo(allConsentButtonView.snp.bottom).offset(23)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(52)
      $0.bottom.equalToSuperview().offset(-20)
    }
  }
  
  public func updateTermsView(for type: Terms.TermsType, with terms: Terms) {
    switch type {
    case .termsOfService:
      self.termOfService.terms = terms
    case .privacyPolicy:
      self.privacyPolicy.terms = terms
    case .locationDataUsage:
      self.locationDataUsage.terms = terms
    }
  }
  
  public func updateAllConsentButtonView(for type: Bool) {
    self.allConsentButtonView.currentState = type ? .checked : .unChecked
  }
  
  public func updateAdvanceButton(for type: Bool) {
    self.advanceButton.currentState = type ? .enabled : .disabled
  }
}
