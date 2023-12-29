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

final class OnboardingTermsController: BaseController {
  private lazy var mainView = OnboardingTermsView()
  typealias Reactor = OnboardingTermsReactor
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if let sheet = self.sheetPresentationController {
      let contentHeight = mainView.frame.height
      let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("customDetent")) { _ in
        return contentHeight
      }
      sheet.detents = [customDetent]
    }
  }
  
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
      uiConfigurator = self
    }
    super.init()
  }
}

extension OnboardingTermsController: ReactorKit.View {
  func bind(reactor: OnboardingTermsReactor) {
    mainView.didTouch
      .subscribe(with: self) { owner, touch in
        switch touch {
        case .allConsent:
          reactor.action.onNext(.toggleAllConsent)
        case .consent(let terms):
          reactor.action.onNext(.toggleConsent(terms))
        case .open(let terms): break
        case .advance:
          owner.dismiss(animated: true)
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
      .map(\.isAllConsented)
      .distinctUntilChanged()
      .bind(with: self) { owner, isAllConsented in
        owner.mainView.updateAllConsentButtonView(for: isAllConsented)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isAdvanceButtonEnabled)
      .distinctUntilChanged()
      .bind(with: self) { owner, isAdvanceButtonEnabled in
        owner.mainView.updateAdvanceButton(for: isAdvanceButtonEnabled)
      }
      .disposed(by: disposeBag)
  }
}

extension OnboardingTermsController: UIConfigurable {
  func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
  }
}
