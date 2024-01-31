//
//  AccountAccessFailedController.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SharedDesignSystem

final class AccountAccessFailedController: BaseController {
  private let failedType: AccountAccessFailedType
  
  private lazy var mainView = AccountAccessFailedView(failedType: failedType)
  
  override func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(52)
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  public init(failedType: AccountAccessFailedType) {
    self.failedType = failedType
    super.init()
  }
}
