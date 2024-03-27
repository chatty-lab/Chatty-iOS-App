//
//  DefaultChatSTOMPRepository.swift
//  DataRepositoryInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import DataNetworkInterface
import DomainChatInterface
import RxSwift

public struct DefaultChatSTOMPRepository: ChatSTOMPRepositoryProtocol {
  private let chatSTOMPService: any ChatSTOMPService
  
  public init(chatSTOMPService: any ChatSTOMPService) {
    self.chatSTOMPService = chatSTOMPService
  }
  
  public func connectSocket() -> PublishSubject<SocketState> {
    return chatSTOMPService.connectSocket()
  }
  
  public func send(_ router: ChatSTOMPRouter) {
    return chatSTOMPService.send(router)
  }
  
  public func socketObserver() -> PublishSubject<ChatMessageProtocol> {
    return chatSTOMPService.socketObserver()
  }
  
  public func connectSTOMP() {
    chatSTOMPService.send(.connectToChatServer)
  }
  
  public func subscribeChatRoom(roomId: String) {
    chatSTOMPService.subscribe(to: roomId)
  }
  
  public func unsubscribeChatRoom(roomId: String) {
    chatSTOMPService.send(.unsubsribeFromChatRoom(roomId: roomId))
  }
  
  public func sendMessage(roomdId: Int, _ type: DomainChatInterface.messageRequestType) {
    chatSTOMPService.send(.sendMessage(.init(roomId: roomdId, senderId: 6, receiverId: 13, content: type.textValue)))
  }
  
}
