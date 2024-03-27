//
//  ChatReactor.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/13/24.
//

import UIKit
import RxSwift
import ReactorKit
import DomainChatInterface
import DomainChat

public final class ChatReactor: Reactor {
  private let chatServerConnectUseCase: DefaultChatSTOMPConnectUseCase
  private let chatSendMessageUseCase: DefaultChatSendMessageUseCase
  private let chatRoomSubscribeUseCase: DefaultChatRoomSubscribeUseCase
  private let getChatMessageStreamUseCase: DefaultGetChatMessageStreamUseCase
  private let getChatMessagesUseCase: DefaultGetChatMessgesUseCase
  
  public let roomViewData: ChatRoomViewData
  
  public enum Action {
    case connectChatServer
    case subscribeToChatRoom(roomId: Int)
    case loadMessages
    case sendMessage(MessageContentType)
    case observeChatMessage
    case scrollToUnreadMessaged
  }
  
  public enum Mutation {
    case setSocketState(SocketState)
    case setMessages([ChatMessageViewData])
    case setUnreadMessageIndexPath(IndexPath?)
  }
  
  public struct State {
    var chatRooms: ChatRoomViewData
    var messages: [ChatMessageViewData] = []
    var socketState: SocketState? = nil
    var unreadMessageIndexPath: IndexPath?
  }
  
  public lazy var initialState: State = .init(chatRooms: roomViewData)
  
  public init(chatServerConnectUseCase: DefaultChatSTOMPConnectUseCase, chatSendMessageUseCase: DefaultChatSendMessageUseCase, chatRoomSubscribeUseCase: DefaultChatRoomSubscribeUseCase, getChatMessageStreamUseCase: DefaultGetChatMessageStreamUseCase, getChatMessagesUseCase: DefaultGetChatMessgesUseCase, roomViewData: ChatRoomViewData) {
    self.chatServerConnectUseCase = chatServerConnectUseCase
    self.chatSendMessageUseCase = chatSendMessageUseCase
    self.chatRoomSubscribeUseCase = chatRoomSubscribeUseCase
    self.getChatMessageStreamUseCase = getChatMessageStreamUseCase
    self.getChatMessagesUseCase = getChatMessagesUseCase
    self.roomViewData = roomViewData
  }
}

extension ChatReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .sendMessage(let message):
      chatSendMessageUseCase.execute(roomId: roomViewData.roomId, content: message.textValue, senderId: 6)
      let message: ChatMessageViewData = .init(roomId: roomViewData.roomId, content: .text(message.textValue), senderType: .currentUser, sendTime: Date())
      var messages = currentState.messages
      messages.append(message)
      return .just(.setMessages(messages))
    case .loadMessages:
      return getChatMessagesUseCase.exectue(roomId: roomViewData.roomId)
        .asObservable()
        .flatMap { messages -> Observable<Mutation> in
          let partnerId = self.roomViewData.recieverProfile.userId
          let reversed = messages.reversed()
          let messagesViewData = reversed.map { ChatMessageViewData(roomId: $0.roomId, content: $0.content, senderType: $0.senderId == partnerId ? .participant(self.roomViewData.recieverProfile.name) : .currentUser, sendTime: $0.sendTime)}
          return .just(.setMessages(messagesViewData))
        }
    case .scrollToUnreadMessaged:
      return .concat([
        .just(.setUnreadMessageIndexPath(nil)),
        .just(.setUnreadMessageIndexPath(nil))
      ])
    case .connectChatServer:
      return chatServerConnectUseCase.connectSocket()
        .asObservable()
        .flatMap { [weak self] _ -> Observable<Mutation> in
          self?.chatServerConnectUseCase.connectSTOMP()
          return .just(.setSocketState(.stompConnected))
        }
    case .subscribeToChatRoom(let roomId):
      chatRoomSubscribeUseCase.execute(roomId: "\(roomId)")
      return .just(.setSocketState(.stompSubscribed))
    case .observeChatMessage:
      return getChatMessageStreamUseCase.execute()
        .asObservable()
        .flatMap { message -> Observable<Mutation> in
          let senderType: ChatParticipantType = message.senderId == self.roomViewData.recieverProfile.userId ? .participant(self.roomViewData.recieverProfile.name) : .currentUser
          var messages = self.currentState.messages
          
          print("받은 메시지 아이디: \(message.senderId)")
          print("상대방 메시지 아이디: \(self.roomViewData.recieverProfile.userId)")
          if case .participant(let name) = senderType {
            let messageViewData = ChatMessageViewData(roomId: message.roomId, content: .text(message.content.textValue), senderType: senderType, sendTime: message.sendTime)
            messages.append(messageViewData)
          }
          
          return .just(.setMessages(messages))
        }
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setMessages(let messages):
      newState.messages = messages
    case .setUnreadMessageIndexPath(let indexPath):
      newState.unreadMessageIndexPath = indexPath
    case .setSocketState(let state):
      newState.socketState = state
    }
    
    return newState
  }
}

public enum SocketState {
  case socketConnected
  case socketDisConnected
  case stompConnected
  case stompDisConnected
  case stompSubscribed
}
