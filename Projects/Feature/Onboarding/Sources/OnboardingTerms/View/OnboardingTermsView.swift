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

final class OnboardingTermsView: BaseView, Touchable {
  // MARK: - View Property
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "채티를 이용하려면 동의가 필요해요"
    $0.font = Font.Pretendard(.SemiBold).of(size: 18)
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .center
    $0.sizeToFit()
  }
  
  private let termContainer: UIView = UIView()
  
  private let termOfService: TermsItemView = TermsItemView(
    term: Terms(
      type: .termsOfService,
      isRequired: true
    )
  )
  
  private let privacyPolicy: TermsItemView = TermsItemView(
    term: Terms(
      type: .privacyPolicy,
      isRequired: true
    )
  )
  
  private let locationDataUsage: TermsItemView = TermsItemView(
    term: Terms(
      type: .locationDataUsage,
      isRequired: false
    )
  )
  
  private let acceptAllButtonView: AcceptAllButton = AcceptAllButton().then {
    typealias Configuration = AcceptAllButton.Configuration
    let uncheckedConfig = Configuration(tintColor: SystemColor.gray500.uiColor)
    let checkedConfig = Configuration(tintColor: SystemColor.primaryNormal.uiColor)
    
    $0.setState(uncheckedConfig, for: .unChecked)
    $0.setState(checkedConfig, for: .checked)
    $0.currentState = .unChecked
  }
  
  private let signUpButton: FillButton = FillButton().then {
    typealias Configuration = FillButton.Configuration
    let enabledConfig = Configuration(backgroundColor: SystemColor.primaryNormal.uiColor, isEnabled: true)
    let disabledConfig = Configuration(backgroundColor: SystemColor.gray300.uiColor, isEnabled: false)
    
    $0.title = "시작하기"
    $0.cornerRadius = 8
    $0.setState(enabledConfig, for: .enabled)
    $0.setState(disabledConfig, for: .disabled)
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - Initialize Method
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setupTitleView()
    setupTermContainer()
    setupAcceptAllButtonView()
    setupSignUpButton()
  }
  
  // MARK: - Bindable
  override func bind() {
    termOfService.touchEventRelay
      .map {
        switch $0 {
        case .open(let terms): return .open(terms)
        case .accept(let terms): return .accept(terms)
        }
      }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
    
    privacyPolicy.touchEventRelay
      .map {
        switch $0 {
        case .open(let terms): return .open(terms)
        case .accept(let terms): return .accept(terms)
        }
      }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
    
    locationDataUsage.touchEventRelay
      .map {
        switch $0 {
        case .open(let terms): return .open(terms)
        case .accept(let terms): return .accept(terms)
        }
      }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
    
    acceptAllButtonView.touchEventRelay
      .map { _ in .acceptAll }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
    
    signUpButton.touchEventRelay
      .map { _ in .signUp }
      .bind(to: self.touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension OnboardingTermsView {
  enum TouchEventType {
    case signUp
    case acceptAll
    case accept(Terms)
    case open(Terms)
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
  
  private func setupAcceptAllButtonView() {
    addSubview(acceptAllButtonView)
    
    acceptAllButtonView.snp.makeConstraints {
      $0.top.equalTo(termContainer.snp.bottom).offset(21)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(46)
    }
  }
  
  private func setupSignUpButton() {
    addSubview(signUpButton)
    
    signUpButton.snp.makeConstraints {
      $0.top.equalTo(acceptAllButtonView.snp.bottom).offset(23)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(52)
      $0.bottom.equalToSuperview().offset(-20)
    }
  }
  
  public func setTermsView(for type: Terms.TermsType, with terms: Terms) {
    switch type {
    case .termsOfService:
      self.termOfService.terms = terms
    case .privacyPolicy:
      self.privacyPolicy.terms = terms
    case .locationDataUsage:
      self.locationDataUsage.terms = terms
    }
  }
  
  public func setAcceptAllButtonViewIsChecked(for state: Bool) {
    self.acceptAllButtonView.currentState = state ? .checked : .unChecked
  }
  
  public func setSignUpButtonIsEnabled(for state: Bool) {
    self.signUpButton.currentState = state ? .enabled : .disabled
  }
}
