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
  func pushToChatRoom(roomViewData: ChatRoomViewData)
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
      getChatRoomListUseCase: dependencyProvider.makeGetChatRoomListUseCase(), 
      chatRoomSubscribeUseCase: dependencyProvider.makeChatRoomSubscribeUseCase(), getChatMessageStreamUseCase: dependencyProvider.makeGetChatMessageStreamUseCase())
    )
    chatListController.delegate = self
    navigationController.pushViewController(chatListController, animated: true)
  }
  
  public func pushToChatRoom(roomViewData: ChatRoomViewData) {
    let chatRoomController = ChatRoomController(reactor: ChatReactor(chatServerConnectUseCase: dependencyProvider.makeChatServerConnectUseCase(), chatSendMessageUseCase: dependencyProvider.makeChatSendMessageUseCase(), chatRoomSubscribeUseCase: dependencyProvider.makeChatRoomSubscribeUseCase(), getChatMessageStreamUseCase: dependencyProvider.makeGetChatMessageStreamUseCase(), getChatMessagesUseCase: dependencyProvider.makeGetChatMessagesUseCase(), roomViewData: roomViewData))
    chatRoomController.hidesBottomBarWhenPushed = true
    navigationController.pushViewController(chatRoomController, animated: true)
  }
}
