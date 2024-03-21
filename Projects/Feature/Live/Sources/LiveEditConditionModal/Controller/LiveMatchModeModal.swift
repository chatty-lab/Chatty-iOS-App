//
//  LiveMatchModeModal.swift
//  FeatureLive
//
//  Created by 윤지호 on 3/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem
import ReactorKit

import DomainLiveInterface

public protocol LiveMatchModeModalDelegate: AnyObject {
  func dismiss()
  func startMatching(_ matchState: MatchConditionState)
}

public final class LiveMatchModeModal: BaseController {
  // MARK: - View Property
  private lazy var mainView = MatchModeModalView()
  
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
  weak var delegate: LiveMatchModeModalDelegate?
  
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

extension LiveMatchModeModal: ReactorKit.View {
  public func bind(reactor: LiveEditConditionModalReactor) {
    mainView.touchEventRelay
      .bind(with: self) { owner, event in
        switch event {
        case .cancel:
          owner.delegate?.dismiss()
        case .toggle(let bool):
          owner.reactor?.action.onNext(.toggleProfileAuthenticationConnection(bool))
        case .matchMode(let matchMode):
          owner.reactor?.action.onNext(.startMatching(matchMode))
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isMatchStarted)
      .distinctUntilChanged()
      .bind(with: self) { owner, bool in
        if bool {
          owner.delegate?.startMatching(reactor.currentState.matchConditionState)
        }
      }
      .disposed(by: disposeBag)
  }
}

extension LiveMatchModeModal {
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

