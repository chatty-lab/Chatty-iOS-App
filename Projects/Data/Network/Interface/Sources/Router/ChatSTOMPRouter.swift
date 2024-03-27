//
//  ChatSTOMPRouter.swift
//  FeatureChatInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import Shared
import DomainChatInterface

public enum ChatSTOMPRouter: STOMPRouter {
  case connectToChatServer
  case disconnectFromChatServer
  case subscribeToChatRoom(roomId: String)
  case unsubsribeFromChatRoom(roomId: String)
  case sendMessage(ChatMessageRequestDTO)
}

extension ChatSTOMPRouter {
  public var command: STOMPCommand {
    switch self {
    case .connectToChatServer:
      return .CONNECT
    case .disconnectFromChatServer:
      return .DISCONNECT
    case .subscribeToChatRoom:
      return .SUBSCRIBE
    case .unsubsribeFromChatRoom:
      return .UNSUBSCRIBE
    case .sendMessage:
      return .SEND
    }
  }
  
  public var id: String {
    switch self {
    case .subscribeToChatRoom, .sendMessage:
      return ""
    default:
      return ""
    }
  }
  
  public var destination: String {
    switch self {
    case .subscribeToChatRoom(let roomId), .unsubsribeFromChatRoom(let roomId):
      return "/sub/chat/\(roomId)"
    case .sendMessage(let messageDTO):
      return "/pub/chat/message/\(messageDTO.roomId)"
    default:
      return ""
    }
  }
  
  public var headers: [String : String] {
    let defaultHeaders: [String: String] = ["accept-version": "1.1, 1.0","content-type": "application/json;charset=UTF-8"]
    return defaultHeaders
  }
  
  public var body: Encodable? {
    switch self {
    case .sendMessage(let messageDTO):
      return messageDTO
    default:
      return nil
    }
  }
}
