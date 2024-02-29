//
//  LiveEditGenderConditionModal.swift
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

public protocol LiveEditGenderConditionModalDelegate: AnyObject {
  func dismiss()
  func editFinished(_ selectedGender: MatchGender)
}

public final class LiveEditGenderConditionModal: BaseController {
  // MARK: - View Property
  private lazy var mainView = EditGenderConditionView()
  
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
  weak var delegate: LiveEditGenderConditionModalDelegate?
  
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

extension LiveEditGenderConditionModal: ReactorKit.View {
  public func bind(reactor: LiveEditConditionModalReactor) {
    mainView.touchEventRelay
      .bind(with: self) { owner, event in
        switch event {
        case .cancel:
          owner.delegate?.dismiss()
        case .checkButton:
          owner.delegate?.editFinished(reactor.currentState.gender)
        case .selectGender(let matchGender):
          owner.reactor?.action.onNext(.selectGender(matchGender))
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.gender)
      .distinctUntilChanged()
      .bind(with: self) { owner, gender in
        owner.mainView.setGenderState(gender)
      }
      .disposed(by: disposeBag)
  }
  
  
}

extension LiveEditGenderConditionModal {
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

