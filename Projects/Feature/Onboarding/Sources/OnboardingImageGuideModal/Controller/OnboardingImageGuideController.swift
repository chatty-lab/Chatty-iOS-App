//
//  AlbumModal.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem
import ReactorKit

public final class OnboardingImageGuideController: BaseController {
  // MARK: - View Property
  private lazy var mainView = ImageGuideView()
  
  // MARK: - Reactor Property
  public typealias Reactor = OnboardingImageGuideReactor
  
  // MARK: - Rx Property
  private let imageRelay = PublishRelay<UIImage?>()
  
  // MARK: - Initialize Method
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
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
  
  weak var delegate: OnboardingImageGuideCoordinatorDelegate?
  
  public override func configureUI() {
    view.addSubview(mainView)
    
    mainView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
  }
}

extension OnboardingImageGuideController: ReactorKit.View {
  public func bind(reactor: OnboardingImageGuideReactor) {
    mainView.touchEventRelay
      .bind(with: self) { owner, touch in
        switch touch {
        case .toggleSegment(let bool):
          owner.reactor?.action.onNext(.toggleSegment(bool))
        case .tabShowAlbumButtom:
          owner.reactor?.action.onNext(.tabPresentAlbumButton)
        }
      }
      .disposed(by: disposeBag)
    
    imageRelay
      .map { Reactor.Action.seletedImage($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.seletedImage)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, image in
        owner.delegate?.didFinishPick(image)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isFirstSegment)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, bool in
        owner.mainView.updateView(bool)
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.isSeleted)
      .distinctUntilChanged()
      .observe(on: MainScheduler.asyncInstance)
      .bind(with: self) { owner, result in
        if result {
          owner.delegate?.pushToAlbumView()
          owner.reactor?.action.onNext(.didPushed)
        }
      }
      .disposed(by: disposeBag)
  }
}

extension OnboardingImageGuideController {
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

//// 임시 이미지 픽커
//extension OnboardingImageGuideController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//  
//}

