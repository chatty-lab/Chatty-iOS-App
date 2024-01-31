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

public protocol OnboardingTermsDelegate: AnyObject {
  func signUp()
}

public final class OnboardingTermsController: BaseController {
  // MARK: - View Property
  private lazy var mainView = OnboardingTermsView()
  
  // MARK: - Reactor Property
  public typealias Reactor = OnboardingTermsReactor
  
  // MARK: - Life Method
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupSheet()
  }
  
  // MARK: - Initialize Method
  public required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  deinit {
    print("해제됨: OnboardingTermsController")
  }
  
  // MARK: - Delegate
  weak var delegate: OnboardingTermsDelegate?
  
  // MARK: - UIConfigurable
  public override func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
  }
}

extension OnboardingTermsController: ReactorKit.View {
  public func bind(reactor: OnboardingTermsReactor) {
    mainView.touchEventRelay
      .subscribe(with: self) { owner, touch in
        switch touch {
        case .acceptAll:
          reactor.action.onNext(.toggleAcceptAll)
        case .accept(let terms):
          reactor.action.onNext(.toggleAccept(terms))
        case .open(let terms):
          print("약관 상세 페이지: \(terms.type.rawValue)")
        case .signUp:
          owner.dismiss(animated: true)
          owner.delegate?.signUp()
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.termsOfService)
      .distinctUntilChanged()
      .bind(with: self) { owner, terms in
        owner.mainView.setTermsView(for: .termsOfService, with: terms)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.privacyPolicy)
      .distinctUntilChanged()
      .bind(with: self) { owner, terms in
        owner.mainView.setTermsView(for: .privacyPolicy, with: terms)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.locationDataUsage)
      .distinctUntilChanged()
      .bind(with: self) { owner, terms in
        owner.mainView.setTermsView(for: .locationDataUsage, with: terms)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isAllAccepted)
      .distinctUntilChanged()
      .bind(with: self) { owner, isAllAccepted in
        owner.mainView.setAcceptAllButtonViewIsChecked(for: isAllAccepted)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isSignUpButtonEnabled)
      .distinctUntilChanged()
      .bind(with: self) { owner, isSignUpButtonEnabled in
        owner.mainView.setSignUpButtonIsEnabled(for: isSignUpButtonEnabled)
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
