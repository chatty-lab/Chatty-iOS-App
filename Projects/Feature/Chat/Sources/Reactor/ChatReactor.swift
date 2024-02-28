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
  
  public enum Action {
    case connectChatServer
    case subscribeToChatRoom(roomId: Int)
    case loadMessages
    case sendMessage(MessageContentType)
    case scrollToUnreadMessaged
  }
  
  public enum Mutation {
    case setSocketState(SocketState)
    case setMessages([ChatMessageViewData])
    case setUnreadMessageIndexPath(IndexPath?)
  }
  
  public struct State {
    var chatRooms: [ChatRoomViewData] = []
    var messages: [ChatMessageViewData] = []
    var unreadMessageIndexPath: IndexPath?
  }
  
  public var initialState: State = .init()
  
  public init(chatServerConnectUseCase: DefaultChatSTOMPConnectUseCase) {
    self.chatServerConnectUseCase = chatServerConnectUseCase
  }
}

extension ChatReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .sendMessage(let message):
      let message: ChatMessageViewData = .init(content: message, senderType: .currentUser, timestamp: Date())
      var messages = currentState.messages
      messages.append(message)
      return .just(.setMessages(messages))
    case .loadMessages:
      let messages = [
        ChatMessageViewData(content: .text("안녕"), senderType: .currentUser, timestamp: Date())
//        ChatMessageViewData(content: .text("그래 안녕"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("안녕 안녕!"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("반가워"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("잘지내?"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("밥 먹었어?"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("보고 싶다"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("다음 주에 언제 봐?"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("글쎄.. 언제 보고 싶은데?"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("음,, 월요일?"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("ㅋㅋㅋ그래 그러자"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("오예"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("뭐 먹을래? 파스타? 타코? 디저트도 봐놨어!"), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("ㅋㅋㅋㅋ이열"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("저번에 먹었던 타코도 맛있긴 했는데"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("먹었던거니까 오랜만에 파스타 먹을까?"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("어딘데?"), senderType: .participant("상대방"), timestamp: Date()),
//        ChatMessageViewData(content: .text("ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 ㅋㅋㅋ가보면 알어 "), senderType: .currentUser, timestamp: Date()),
//        ChatMessageViewData(content: .text("좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ 좋아ㅋㅋㅋ"), senderType: .participant("상대방"), timestamp: Date()),
      ]
      return .just(.setMessages(messages))
    case .scrollToUnreadMessaged:
      return .concat([
        .just(.setUnreadMessageIndexPath(nil)),
        .just(.setUnreadMessageIndexPath(nil))
      ])
    case .connectChatServer:
      return chatServerConnectUseCase.execute()
        .flatMap { result -> Observable<Mutation> in
          return .just(.setSocketState(.success))
        }
        .catch { error in
          return .just(.setSocketState(.failed))
        }
    case .subscribeToChatRoom(let roomId):
      return .just(.setSocketState(.success))
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case .setMessages(let messages):
      newState.messages = messages
    case .setUnreadMessageIndexPath(let indexPath):
      newState.unreadMessageIndexPath = indexPath
    case .setSocketState:
      break
    }
    
    return newState
  }
}

public enum SocketState {
  case success
  case failed
}
