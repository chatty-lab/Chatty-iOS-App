//
//  ChatListReactor.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/25/24.
//

import UIKit
import RxSwift
import ReactorKit
import DomainChatInterface
import DomainChat

public final class ChatListReactor: Reactor {
  private let chatServerConnectUseCase: DefaultChatSTOMPConnectUseCase
  private let getChatRoomListUseCase: DefaultGetChatRoomListUseCase
  private let chatRoomSubscribeUseCase: DefaultChatRoomSubscribeUseCase
  private let getChatMessageStreamUseCase: DefaultGetChatMessageStreamUseCase
  
  private let disposeBag = DisposeBag()
  
  public enum Action {
    case connectSocketServer
    case loadChatRooms
    case observeChatMessage
    case subscribeChatRoom
  }
  
  public enum Mutation {
    case setSocketState(SocketState)
    case setChatRooms([ChatRoomViewData])
    case setChatMessage(ChatMessageViewData)
  }
  
  public struct State {
    var chatRooms: [ChatRoomViewData]? = nil
    var socketState: SocketState? = nil
    var chatMessages: [Int: ChatMessageViewData]? = nil
  }
  
  public let initialState: State = .init()
  
  public init(chatServerConnectUseCase: DefaultChatSTOMPConnectUseCase, getChatRoomListUseCase: DefaultGetChatRoomListUseCase, chatRoomSubscribeUseCase: DefaultChatRoomSubscribeUseCase, getChatMessageStreamUseCase: DefaultGetChatMessageStreamUseCase) {
    self.chatServerConnectUseCase = chatServerConnectUseCase
    self.getChatRoomListUseCase = getChatRoomListUseCase
    self.chatRoomSubscribeUseCase = chatRoomSubscribeUseCase
    self.getChatMessageStreamUseCase = getChatMessageStreamUseCase
  }
}

extension ChatListReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .loadChatRooms:
      return getChatRoomListUseCase.execute()
        .asObservable()
        .flatMap { rooms -> Observable<Mutation> in
          let _ = rooms.map { room in
            self.chatRoomSubscribeUseCase.execute(roomId: "\(room.roomId)")
          }
          let roomViewData = rooms.map {
            ChatRoomViewData(roomId: $0.roomId, recieverProfile: .init(userId: $0.senderId, name: $0.senderNickname, profileImageURL: $0.senderImageURL), lastMessage: .init(roomId: $0.roomId, content: .text($0.lastMessage ?? ""), senderType: .participant($0.senderNickname), sendTime: $0.createdAt))
          }
          return .just(.setChatRooms(roomViewData))
        }
    case .observeChatMessage:
      return getChatMessageStreamUseCase.execute()
        .asObservable()
        .flatMap { message -> Observable<Mutation> in
          let messageViewData = ChatMessageViewData(roomId: message.roomId, content: .text(message.content.textValue), senderType: .participant(""), sendTime: message.sendTime)
          return .just(.setChatMessage(messageViewData))
        }
    case .connectSocketServer:
      return chatServerConnectUseCase.connectSocket()
        .asObservable()
        .flatMap { state -> Observable<Mutation> in
          self.chatServerConnectUseCase.connectSTOMP()
          switch state {
          case .socketConnected:
            return .just(.setSocketState(.socketConnected))
          case .stompConnected:
            return .just(.setSocketState(.stompConnected))
          }
        }
    case .subscribeChatRoom:
        getChatRoomListUseCase.execute()
        .subscribe(with: self) { owner, rooms in
            let _ = rooms.map { room in
              self.chatRoomSubscribeUseCase.execute(roomId: "\(room.roomId)")
            }
        }
        .disposed(by: disposeBag)
      return .empty()
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newSate = state
    switch mutation {
    case .setSocketState(let status):
      newSate.socketState = status
    case .setChatRooms(let array):
      newSate.chatRooms = array
    case .setChatMessage(let messages):
      break
    }
    return newSate
  }
}
