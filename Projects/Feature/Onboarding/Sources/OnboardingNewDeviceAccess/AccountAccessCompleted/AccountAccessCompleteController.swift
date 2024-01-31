//
//  AccountAccessCompletedController.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 1/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SharedDesignSystem

final class AccountAccessCompletedController: BaseController {
  private let mainView = AccountAccessCompletedView()
  
  override func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(52)
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
}
