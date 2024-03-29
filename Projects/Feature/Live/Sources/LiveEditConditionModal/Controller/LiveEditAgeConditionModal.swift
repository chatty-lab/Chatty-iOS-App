//
//  LiveEditAgeConditionModal.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem
import ReactorKit

import DomainLiveInterface

public protocol LiveEditAgeConditionModalDelegate: AnyObject {
  func dismiss()
  func editFinished()
}

public final class LiveEditAgeConditionModal: BaseController {
  // MARK: - View Property
  private lazy var mainView = EditAgeConditionView()
  
  // MARK: - Reactor Property
  public typealias Reactor = LiveEditConditionModalReactor
  
  // MARK: - LifeCycle Method
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Initialize Method
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupSheet()
  }
  
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  // MARK: - Delegate
  weak var delegate: LiveEditAgeConditionModalDelegate?
  
  // MARK: - UIConfigurable
  public override func configureUI() {
    view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
  }
  
  deinit {
    print("해제됨: LiveEditGenderConditionModal")
  }
}

extension LiveEditAgeConditionModal: ReactorKit.View {
  public func bind(reactor: LiveEditConditionModalReactor) {
    mainView.touchEventRelay
      .bind(with: self) { owner, event in
        switch event {
        case .cancel:
          owner.delegate?.dismiss()
        case .checkButton:
          owner.reactor?.action.onNext(.tabSaveButton)
        case .selectAgeRange(let matchAgeRange):
          owner.reactor?.action.onNext(.selectAge(matchAgeRange))
        case .resetRange:
          owner.reactor?.action.onNext(.resetAge)
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.matchConditionState.ageRange)
      .distinctUntilChanged()
      .bind(with: self) { owner, ageRange in
        owner.mainView.setAgeCondition(ageRange)
      }
      .disposed(by: disposeBag)

    reactor.state
      .map(\.isSuccessSaved)
      .distinctUntilChanged()
      .bind(with: self) { owner, bool in
        if bool {
          owner.delegate?.editFinished()
        }
      }
      .disposed(by: disposeBag)
  }
  
  
}

extension LiveEditAgeConditionModal {
  private func setupSheet() {
    if let sheet = self.sheetPresentationController {
      let contentHeight = mainView.frame.height
      let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("custemDetent")) { _ in
        return contentHeight
      }
      sheet.detents = [customDetent]
      sheet.preferredCornerRadius = 16
    }
  }
}
