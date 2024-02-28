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
  
  private func setupCollectionView() {
    chatAdapter.delegate = self
  }
  
  public override func setNavigationBar() {
    print("네비게이션 바 세팅")
    let headerView = CustomNavigationBarItem(view: header)
    let bellButton = CustomNavigationBarButton(image: UIImage(asset: Images.bell)!)
    customNavigationController?.customNavigationBarConfig = CustomNavigationBarConfiguration(titleView: headerView, titleAlignment: .leading, rightButtons: [bellButton])
  }
}

extension ChatListController: ReactorKit.View {
  public func bind(reactor: Reactor) {
    rx.viewDidLoad
      .map { .loadChatRooms }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state
      .map(\.chatRooms)
      .bind(with: self) { owner, rooms in
        if rooms.isEmpty {
          owner.mainView.setEmptyView()
        } else {
          owner.mainView.removeEmptyView()
          owner.chatAdapter.applySnapShot(rooms: rooms)
        }
      }
      .disposed(by: disposeBag)
  }
}

extension ChatListController: ChatListCollectionViewAdapterDelegate {
  func chatListCollectionViewAdapter(_ adapter: ChatListCollectionViewAdapter, didSelectChatRoom room: ChatRoomViewData) {
    delegate?.pushToChatRoom(roomId: room.roomId)
  }
}
