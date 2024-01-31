//
//  OnboardingPhoneAuthenticationSuccessController.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SharedDesignSystem

final class OnboardingPhoneAuthenticationSuccessController: BaseController {
  // MARK: - View Property
  private let mainView = OnboardingPhoneAuthenticationSuccessView()
  
  // MARK: - UIConfigurable
  override func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
