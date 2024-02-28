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
  
  public enum Action {
    case connectChatServer
    case loadChatRooms
  }
  
  public enum Mutation {
    case setSocketState(SocketState)
    case setChatRooms([ChatRoomViewData])
  }
  
  public struct State {
    var chatRooms: [ChatRoomViewData] = []
  }
  
  public let initialState: State = .init()
  
  public init(chatServerConnectUseCase: DefaultChatSTOMPConnectUseCase, getChatRoomListUseCase: DefaultGetChatRoomListUseCase) {
    self.chatServerConnectUseCase = chatServerConnectUseCase
    self.getChatRoomListUseCase = getChatRoomListUseCase
  }
}

extension ChatListReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .connectChatServer:
      return chatServerConnectUseCase.execute()
        .flatMap { result -> Observable<Mutation> in
          return .just(.setSocketState(.success))
        }
        .catch { error in
          return .just(.setSocketState(.failed))
        }
    case .loadChatRooms:
      let roomViewData = [ChatRoomViewData(roomId: 6, recieverProfile: .init(userId: 6, name: "아아아", profileImage: .init()), lastMessage: .init(content: .text("asd"), senderType: .currentUser, timestamp: Date()))]
      return .just(.setChatRooms(roomViewData))
//      return getChatRoomListUseCase.execute()
//        .asObservable()
//        .flatMap { rooms -> Observable<Mutation> in
//          print("asdasd")
////          let roomViewData = rooms.map { ChatRoomViewData(roomId: $0.roomId, recieverProfile: , lastMessage: <#T##ChatMessageViewData#>)}
//          return .just(.setChatRooms(roomViewData))
//        }
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newSate = state
    switch mutation {
    case .setSocketState(let _):
      break
    case .setChatRooms(let array):
      newSate.chatRooms = array
    }
    return newSate
  }
}
