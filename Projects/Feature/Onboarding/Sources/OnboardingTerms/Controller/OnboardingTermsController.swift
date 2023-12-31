//
//  OnboardingTermsController.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import ReactorKit
import RxSwift
import SharedDesignSystem

protocol OnboardingTermsDelegate: AnyObject {
  func signUp()
}

final class OnboardingTermsController: BaseController {
  // MARK: - View Property
  private lazy var mainView = OnboardingTermsView()
  
  // MARK: - Reactor Property
  typealias Reactor = OnboardingTermsReactor
  
  // MARK: - Rx Property
  var disposeBag = DisposeBag()
  
  // MARK: - Life Method
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupSheet()
  }
  
  // MARK: - Initialize Method
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  // MARK: - Delegate
  weak var delegate: OnboardingTermsDelegate?
  
  // MARK: - UIConfigurable
  override func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
  }
}

extension OnboardingTermsController: ReactorKit.View {
  func bind(reactor: OnboardingTermsReactor) {
    mainView.didTouch
      .subscribe(with: self) { owner, touch in
        switch touch {
        case .acceptAll:
          reactor.action.onNext(.toggleAcceptAll)
        case .accept(let terms):
          reactor.action.onNext(.toggleAccept(terms))
        case .open(let terms):
          print("약관 상세 페이지: \(terms.type.rawValue)")
        case .signUp:
          owner.delegate?.signUp()
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.termsOfService)
      .distinctUntilChanged()
      .bind(with: self) { owner, terms in
        owner.mainView.updateTermsView(for: .termsOfService, with: terms)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.privacyPolicy)
      .distinctUntilChanged()
      .bind(with: self) { owner, terms in
        owner.mainView.updateTermsView(for: .privacyPolicy, with: terms)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.locationDataUsage)
      .distinctUntilChanged()
      .bind(with: self) { owner, terms in
        owner.mainView.updateTermsView(for: .locationDataUsage, with: terms)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isAllAccepted)
      .distinctUntilChanged()
      .bind(with: self) { owner, isAllAccepted in
        owner.mainView.updateAcceptAllButtonView(for: isAllAccepted)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isSignUpButtonEnabled)
      .distinctUntilChanged()
      .bind(with: self) { owner, isSignUpButtonEnabled in
        owner.mainView.updateSignUpButton(for: isSignUpButtonEnabled)
      }
      .disposed(by: disposeBag)
  }
}

extension OnboardingTermsController {
  private func setupSheet() {
    if let sheet = self.sheetPresentationController {
      let contentHeight = mainView.frame.height
      let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("customDetent")) { _ in
        return contentHeight
      }
      sheet.detents = [customDetent]
      sheet.preferredCornerRadius = 16
    }
  }
}
