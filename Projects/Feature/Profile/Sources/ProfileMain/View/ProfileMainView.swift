//
//  ProfileMainView.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/17/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

final class ProfileMainView: BaseView, Touchable {
  // MARK: - View Property
  private let profileBoxView: ProfileMainBoxView = ProfileMainBoxView().then {
    $0.backgroundColor = .white
  }
  
  private let profileCashsItemView: ProfileMainCashItemsView = ProfileMainCashItemsView().then {
    $0.backgroundColor = .white
  }
  
  private let problemServicesView: ProfileMainProblemServicesView = ProfileMainProblemServicesView().then {
    $0.backgroundColor = .white
  }

  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  var touchEventRelay: PublishRelay<TouchEventType> = .init()

  // MARK: - UIConfigurable
  override func configureUI() {
    self.backgroundColor = SystemColor.gray100.uiColor
    setupProfileBoxView()
    setupCashItemButtons()
    setupProblemServicesView()
  }
  
  // MARK: - UIBindable
  override func bind() {
  
    
    problemServicesView.touchEventRelay
      .map { event in
        switch event {
        case .problemNotice:
          return TouchEventType.problemNotice
        case .problemFrequentlyQuestion:
          return TouchEventType.problemFrequentlyQuestion
        case .problemContactService:
          return TouchEventType.problemContactService
        }
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension ProfileMainView {
  enum TouchEventType {
    case editProfile
    
    case possessionItems
    case membership
    
    case problemNotice
    case problemFrequentlyQuestion
    case problemContactService
  }
}

extension ProfileMainView {
  private func setupProfileBoxView() {
    addSubview(profileBoxView)
    profileBoxView.snp.makeConstraints {
      $0.top.horizontalEdges.equalToSuperview()
      $0.height.equalTo(243)
    }
  }
  
  private func setupCashItemButtons() {
    addSubview(profileCashsItemView)
    profileCashsItemView.snp.makeConstraints {
      $0.top.equalTo(profileBoxView.snp.bottom)
      $0.height.equalTo(162)
      $0.horizontalEdges.equalToSuperview()
    }
  }
  
  private func setupProblemServicesView() {
    addSubview(problemServicesView)
    problemServicesView.snp.makeConstraints {
      $0.top.equalTo(profileCashsItemView.snp.bottom).offset(5)
      $0.horizontalEdges.bottom.equalToSuperview()
    }
  }
}
