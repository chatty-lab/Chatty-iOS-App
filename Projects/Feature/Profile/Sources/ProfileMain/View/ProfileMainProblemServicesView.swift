//
//  ProblemServicesView.swift
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

final class ProfileMainProblemServicesView: BaseView, Touchable {
  // MARK: - View Property
  private let problemNotice: IconTitleButton = IconTitleButton().then {
    $0.setState(
      image: Images.flag.image,
      title: "공지사항"
    )
  }
  
  private let problemFrequentlyQuestion: IconTitleButton = IconTitleButton().then {
    $0.setState(
      image: Images.pin.image,
      title: "자주 묻는 질문"
    )
  }
  
  private let problemContactService: IconTitleButton = IconTitleButton().then {
    $0.setState(
      image: Images.informationCircle.image,
      title: "서비스 문의"
    )
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  // MARK: - Touchable Property
  var touchEventRelay: PublishRelay<TouchEventType> = .init()
  // MARK: - Initialize Method
  // MARK: - UIConfigurable
  override func configureUI() {
    setupButtons()
  }
  
  // MARK: - UIBindable
  override func bind() {
    problemNotice.touchEventRelay
      .map { _ in TouchEventType.problemNotice }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    problemFrequentlyQuestion.touchEventRelay
      .map { _ in TouchEventType.problemFrequentlyQuestion }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    problemContactService.touchEventRelay
      .map { _ in TouchEventType.problemContactService }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension ProfileMainProblemServicesView {
  enum TouchEventType {
    case problemNotice
    case problemFrequentlyQuestion
    case problemContactService
  }
}

extension ProfileMainProblemServicesView {
  private func setupButtons() {
    addSubview(problemNotice)
    addSubview(problemFrequentlyQuestion)
    addSubview(problemContactService)
    
    problemNotice.snp.makeConstraints {
      $0.top.equalToSuperview().inset(15)
      $0.height.equalTo(54)
      $0.horizontalEdges.equalToSuperview()
    }
    
    problemFrequentlyQuestion.snp.makeConstraints {
      $0.top.equalTo(problemNotice.snp.bottom)
      $0.height.equalTo(54)
      $0.horizontalEdges.equalToSuperview()
    }
    
    problemContactService.snp.makeConstraints {
      $0.top.equalTo(problemFrequentlyQuestion.snp.bottom)
      $0.height.equalTo(54)
      $0.horizontalEdges.equalToSuperview()
    }
  }
}
