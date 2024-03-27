//
//  ChatRoomController.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/9/24.
//

import UIKit
import ReactorKit
import SharedDesignSystem

public final class ChatRoomController: BaseController {
  private let mainView = ChatRoomView()
  private lazy var chatAdapter = ChatRoomCollectionViewAdapter(collectionView: mainView.collectionView)
  
  public typealias Reactor = ChatReactor
  
  public override func loadView() {
    view = mainView
  }
  
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  public override func setNavigationBar() {
    guard let title = reactor?.roomViewData.recieverProfile.name else { return }
    self.customNavigationController?.customNavigationBarConfig = CustomNavigationBarConfiguration(
      titleView: .init(title: title),
      backgroundColor: SystemColor.basicWhite.uiColor,
      backgroundAlpha: 0.97)
  }
}

extension ChatRoomController: ReactorKit.View {
  public func bind(reactor: Reactor) {
    self.rx.viewDidLoad
      .map { .loadMessages }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.rx.viewDidLoad
      .map { .connectChatServer }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.rx.viewDidAppear
      .map { _ in .scrollToUnreadMessaged }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    mainView.inputEventRelay
      .map { .sendMessage($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.socketState)
      .distinctUntilChanged()
      .subscribe(with: self) { owner, state in
        print("소켓 상태 변한다!!!!")
        switch state {
        case .stompConnected:
          owner.reactor?.action.onNext(.observeChatMessage)
        default:
          break
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.messages)
      .distinctUntilChanged()
      .subscribe(with: self) { owner, messages in
        owner.chatAdapter.applySnapshot(messages: messages, animatingDifferences: false)
      }
      .disposed(by: disposeBag)
  }
}
