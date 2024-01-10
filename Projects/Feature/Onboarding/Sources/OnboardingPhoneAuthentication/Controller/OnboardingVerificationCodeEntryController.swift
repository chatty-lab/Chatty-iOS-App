//
//  OnboardingVerificationCodeEntryController.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 1/8/24.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SharedDesignSystem

public final class OnboardingVerificationCodeEntryController: BaseController {
  // MARK: - View Property
  private let mainView = OnboardingVerificationCodeEntryView()
  
  // MARK: - Reactor Property
  public typealias Reactor = OnboardingPhoneAuthenticationReactor
  
  // MARK: - Initialize Method
  public required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  deinit {
    print("해제됨: OnboardingVerificationCodeEntryController")
  }
  
  // MARK: - Life Method
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    mainView.activateVerificationCodeField()
  }
  
  public override func configureUI() {
    baseNavigationController?.setBaseNavigationBarHidden(false, animated: true)
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(52)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}

extension OnboardingVerificationCodeEntryController: ReactorKit.View {
  public func bind(reactor: OnboardingPhoneAuthenticationReactor) {
    print(reactor.currentState.isSendSMSButtonEnabled)
    
    reactor.state
      .map(\.phoneNumber)
      .bind(with: self) { owner, phoneNumber in
        owner.mainView.phoneNumber = phoneNumber
      }
      .disposed(by: disposeBag)
  }
}
