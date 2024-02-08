//
//  OnboardingAccountOwnerCheckController.swift
//  FeatureOnboardingInterface
//
//  Created by HUNHIE LEE on 1/30/24.
//

import UIKit
import RxSwift
import SharedDesignSystem

public final class OnboardingAccountOwnerCheckController: BaseController {
  // MARK: - View Property
  private let mainView = OnboardingAccountOwnerCheckView()
  
  weak var delegate: AccountOwnerCheckDelegate?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  public override func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(52)
      $0.horizontalEdges.bottom.equalToSuperview()
    }
  }
  
  public override func bind() {
    mainView.touchEventRelay
      .subscribe(with: self) { owner, touch in
        switch touch {
        case .ownedAccount:
          owner.delegate?.pushToQuestion(step: .nickname)
        case .createAccount:
          print("새 계정 만들기~")
        }
      }
      .disposed(by: disposeBag)
  }
}
