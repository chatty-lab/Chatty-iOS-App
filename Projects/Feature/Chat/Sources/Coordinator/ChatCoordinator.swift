//
//  ChatCoordinator.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/12/24.
//

import Foundation
import Shared
import SharedDesignSystem
import FeatureChatInterface

public protocol ChatCoordinatorDelegate: AnyObject {
  func pushToChatRoom(roomId: Int)
}

public final class ChatCoordinator: BaseCoordinator, ChatCoordinatorDelegate {
  public override var type: CoordinatorType {
    return .chat
  }
  
  private let dependencyProvider: FeatureChatDependecyProvider
  
  public init(navigationController: CustomNavigationController, dependencyProvider: FeatureChatDependecyProvider) {
    self.dependencyProvider = dependencyProvider
    super.init(navigationController: navigationController)
  }
  
  public override func start() {
    let chatListController = ChatListController(reactor: ChatListReactor(
      chatServerConnectUseCase:dependencyProvider.makeChatServerConnectUseCase(),
      getChatRoomListUseCase: dependencyProvider.makeGetChatRoomListUseCase())
    )
    chatListController.delegate = self
    navigationController.pushViewController(chatListController, animated: true)
  }
  
  public func pushToChatRoom(roomId: Int) {
    let chatRoomController = ChatRoomController(reactor: ChatReactor(chatServerConnectUseCase: dependencyProvider.makeChatServerConnectUseCase()))
    navigationController.pushViewController(chatRoomController, animated: true)
  }
}
