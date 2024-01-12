//
//  OnboardingProfileController.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import ReactorKit
import RxSwift
import SharedDesignSystem

public final class OnboardingProfileController: BaseController {
  // MARK: - View
  private let profileView: OnboardingProfileView = OnboardingProfileView()
  
  // MARK: - Reactor Property
  public typealias Reactor = OnboardingProfileReactor
  
  // MARK: - Life Method
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Initialize Method
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  public weak var delegate: OnboardingProfileCoordinatorProtocol?
  
  // MARK: - UIConfigurable
  public override func configureUI() {
    view.addSubview(profileView)
    profileView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension OnboardingProfileController: ReactorKit.View {
  public func bind(reactor: OnboardingProfileReactor) {
    
    profileView.touchEventRelay
      .bind(with: self) { owner, touch in
        switch touch {
        case .tabGender(let gender):
          owner.reactor?.action.onNext(.toggleGender(gender))
        case .setBirth(let date):
          owner.reactor?.action.onNext(.selectBirth(date))
        case .continueButton:
          owner.reactor?.action.onNext(.tabContinueButton)
        case .tabImagePicker:
          owner.reactor?.action.onNext(.tabImagePicker)
        case .toggleMBTI(let mbti, let state):
          owner.reactor?.action.onNext(.toggleMBTI(mbti, state))
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isSuccessSave)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, result in
        if result {
          let nextType = reactor.currentState.viewState.type.nextViewType
          if nextType != .none {
            owner.delegate?.pushToNextView(reactor.currentState.viewState)
            owner.reactor?.action.onNext(.didPushed)
          } else {
            owner.delegate?.switchToMainTab()
          }
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.viewState.type)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, type in
        owner.profileView.updateTitleTextView(type, nickName: reactor.currentState.viewState.nickName)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isContinueEnabled)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, state in
        owner.profileView.updateContinuBtn(state)
      }
      .disposed(by: disposeBag)
    
    // Gender
    reactor.state
      .map(\.viewState.gender)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, gender in
        owner.profileView.setGender(gender)
      }
      .disposed(by: disposeBag)
    
    // Image
    reactor.state
      .map(\.isPickingImage)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, result in
        if result {
          owner.delegate?.presentModal()
          owner.reactor?.action.onNext(.didPushed)
        }
      }
      .disposed(by: disposeBag)
    
    // MBTI
    reactor.state
      .map(\.viewState.mbti)
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, mbti in
        owner.profileView.updateMBTIView(mbti)
      }
      .disposed(by: disposeBag)
  }
}

