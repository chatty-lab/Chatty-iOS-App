//
//  ChatListController.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/22/24.
//

import UIKit
import ReactorKit
import SharedDesignSystem

public final class ChatListController: BaseController {
  private let mainView = ChatListView()
  private lazy var chatAdapter = ChatListCollectionViewAdapter(collectionView: mainView.collectionView)
  private let header = ChatListHeaderView()
  
  public weak var delegate: ChatCoordinatorDelegate?
  public typealias Reactor = ChatListReactor
  
  public override func loadView() {
    view = mainView
  }
  
  required init(reactor: Reactor) {
    defer {
      self.reactor = reactor
    }
    super.init()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }
  

  
  public override func configureUI() {
    
  }
  
  private func setupCollectionView() {
    chatAdapter.delegate = self
  }
  
  public override func setNavigationBar() {
    let headerView = CustomNavigationBarItem(title: "채팅")
    let bellButton = CustomNavigationBarButton(image: UIImage(asset: Images.bell)!)
    customNavigationController?.customNavigationBarConfig = CustomNavigationBarConfiguration(titleView: headerView, titleAlignment: .leading, rightButtons: [bellButton])
    
    customNavigationController?.navigationBarEvents(of: NavigationBar.self)
      .subscribe(with: self, onNext: { owner, bar in
        switch bar {
        case .alarm:
          owner.reactor?.action.onNext(.subscribeChatRoom)
        }
      })
      .disposed(by: disposeBag)
  }
  
  enum NavigationBar: Int, IntCaseIterable {
    case alarm
  }
}

extension ChatListController: ReactorKit.View {
  public func bind(reactor: Reactor) {
    rx.viewIsAppear
      .map { _ in .loadChatRooms }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    rx.viewDidAppear
      .map { _ in .connectSocketServer }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.chatRooms)
      .bind(with: self) { owner, rooms in
        guard let rooms else { return }
        if rooms.isEmpty {
          owner.mainView.setEmptyView()
        } else {
          print("새로고침")
          owner.mainView.removeEmptyView()
          owner.chatAdapter.applySnapShot(rooms: rooms)
        }
      }
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.socketState)
      .distinctUntilChanged()
      .bind(with: self) { owner, state in
        guard let state else { return }
        switch state {
        case .socketConnected:
          return
        case .stompConnected:
          reactor.action.onNext(.loadChatRooms)
          reactor.action.onNext(.observeChatMessage)
        default:
          return
        }
      }
      .disposed(by: disposeBag)
  }
}

extension ChatListController: ChatListCollectionViewAdapterDelegate {
  func chatListCollectionViewAdapter(_ adapter: ChatListCollectionViewAdapter, didSelectChatRoom room: ChatRoomViewData) {
    delegate?.pushToChatRoom(roomViewData: room)
  }
}
