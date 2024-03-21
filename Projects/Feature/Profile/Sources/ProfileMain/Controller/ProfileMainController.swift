//
//  ProfileMainViewController.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/17/24.
//

import UIKit
import SharedDesignSystem

import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

protocol ProfileMainControllerDelegate: AnyObject {
  
}

final class ProfileMainController: BaseController {
  // MARK: - View Property
  private let backgroundImageView: UIImageView = UIImageView().then {
    $0.image = Images.matchHomeBackimage.image
    $0.backgroundColor = .white
    $0.contentMode = .scaleAspectFit
  }
  private let mainView = ProfileMainView()
    
  // MARK: - Reactor Property
  typealias Reactor = ProfileMainReactor
  
  // MARK: - Delegate
  weak var delegate: ProfileMainControllerDelegate?
  
  // MARK: - Life Method
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Initialize Method
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  deinit {
    print("해제됨: LiveMainController")
  }
  
   // MARK: - UIConfigurable
  override func configureUI() {
    setView()
  }
  
  override func setNavigationBar() {
    let bellButton = CustomNavigationBarButton(image: Images.bell.image)
    let settingButton = CustomNavigationBarButton(image: Images.setting.image)
    customNavigationController?.customNavigationBarConfig = CustomNavigationBarConfiguration(
      rightButtons: [bellButton, settingButton]
    )
    customNavigationController?.navigationBarEvents(of: BarTouchEvent.self)
      .bind(with: self) { owner, event in
        switch event {
        case .notification:
          print("push noti")
        case .setting:
          print("push setting")
        }
      }
      .disposed(by: disposeBag)
  }
  
  enum BarTouchEvent: Int, IntCaseIterable {
    case notification
    case setting
  }
}

extension ProfileMainController: ReactorKit.View {
  func bind(reactor: ProfileMainReactor) {
    
  }
}

extension ProfileMainController {
  private func setView() {
    self.view.addSubview(mainView)
    mainView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(52)
      $0.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}
