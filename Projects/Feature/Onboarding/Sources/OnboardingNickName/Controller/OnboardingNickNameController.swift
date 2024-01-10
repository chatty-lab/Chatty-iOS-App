//
//  ObboardingNickNameController.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 1/4/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import ReactorKit
import SharedDesignSystem

public final class OnboardingNickNameController: BaseController {
  // MARK: - ViewProperty
  private let nickNameView: OnboardingNickNameView = OnboardingNickNameView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
  
  // MARK: - Rx Property
  public var disposeBag = DisposeBag()
  
  // MARK: - Reactor
  public typealias Reactor = OnboardingNickNameReactor

  // MARK: - Life Cycle
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Initialize Method
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
      uiConfigurator = self
    }
    super.init()
  }
  
  public var delegate: OnboardingNickNameCoordinatorProtocol?
}

extension OnboardingNickNameController: ReactorKit.View {
  public func bind(reactor: OnboardingNickNameReactor) {
    nickNameView.didTouch
      .bind(with: self) { owner, touch in
        switch touch {
        case .removeText:
          owner.reactor?.action.onNext(.tabResetText)
        case .continueButton:
          owner.reactor?.action.onNext(.tabContinueButton)
        }
      }
      .disposed(by: disposeBag)
    
    nickNameView.textRelay
      .map { str in
        return Reactor.Action.inputText(str) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isButtonEnabled)
      .distinctUntilChanged()
      .bind(with: self) { owner, bool in
        owner.nickNameView.updateContinueButtonEnabled(bool)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.checkedResult)
      .distinctUntilChanged()
      .bind(with: self) { owner, result in
        owner.nickNameView.updateTextFieldBottomLine(result)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.successSave)
      .distinctUntilChanged()
      .bind(with: self) { owner, result in
        if result {
          owner.delegate?.pushToProfile(reactor.currentState.nickNameText)
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isLoading)
      .distinctUntilChanged()
      .bind(with: self) { owner, result in
        // 로딩뷰
      }
      .disposed(by: disposeBag)
  }
}

extension OnboardingNickNameController: UIConfigurable {
  public func configureUI() {
    view.addSubview(nickNameView)
    nickNameView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}

