//
//  OnboardingTermsController.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import SharedDesignSystem

final class OnboardingTermsController: UIViewController {
  private lazy var mainView = OnboardingTermsView().then {
    $0.delegate = self
  }
  
  override func loadView() {
    super.loadView()
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(asset: Colors.basicWhite)
  }
}

extension OnboardingTermsController: OnboardingTermsViewDelegate {
  func didTapContinue() {
    dismiss(animated: true)
  }
}
