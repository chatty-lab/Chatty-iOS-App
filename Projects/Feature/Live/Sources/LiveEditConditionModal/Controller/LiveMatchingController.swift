//
//  LiveMatchingController.swift
//  FeatureLive
//
//  Created by 윤지호 on 3/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReactorKit
import SharedDesignSystem

protocol LiveMatchingDelegate: AnyObject {
  func dismiss()
  func successMatching()
}

final class LiveMatchingController: BaseController {
  // MARK: - View Property
  private let mainView = LiveMatchingView()
  
  // MARK: - Reactor Property
  typealias Reactor = LiveEditConditionModalReactor
  
  // MARK: - Delegate
  weak var delegate: LiveMatchingDelegate?
  
  // MARK: - Life Method
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    reactor?.action.onNext(.matchingStart)
  }
  
  // MARK: - Initialize Method
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  // MARK: - UIConfigurable
  override func configureUI() {
    self.view = mainView
  }
  
  deinit {
    print("해제됨: LiveMatchingController")
  }
}

extension LiveMatchingController: ReactorKit.View {
  func bind(reactor: LiveEditConditionModalReactor) {
    mainView.touchEventRelay
      .bind(with: self) { owner, event in
        switch event {
        case .cancel:
          owner.delegate?.dismiss()
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.matchConditionState)
      .bind(with: self) { owner, condition in
        owner.mainView.setCondition(condition)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.matchingState)
      .bind(with: self) { owner, state in
        owner.mainView.setMatchingState(state)
      }
      .disposed(by: disposeBag)
  }
}
