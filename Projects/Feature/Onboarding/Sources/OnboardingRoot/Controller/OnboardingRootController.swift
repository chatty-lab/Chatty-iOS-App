//
//  OnboardingRootController.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import RxSwift
import SharedDesignSystem

public final class OnboardingRootController: BaseController {
  // MARK: - View
  private let mainView = OnboardingRootView()
  
  // MARK: - Life Method
  public override func loadView() {
    super.loadView()
    view = mainView
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // MARK: - Delegate
  weak var delegate: OnboardingRootCoordinatorProtocol?
  
  deinit {
    print("해제됨: OnboardingRootController")
  }
  
  // MARK: - Bindable
  public override func bind() {
    mainView.touchEventRelay
      .bind(with: self) { owner, touch in
        switch touch {
        case .signIn:
          owner.delegate?.pushToLogin()
        case .signUp:
          owner.delegate?.presentToTerms()
        }
      }
      .disposed(by: disposeBag)
  }
}
