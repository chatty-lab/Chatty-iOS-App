//
//  ChatSTOMPRouter.swift
//  FeatureChatInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import Shared

public enum ChatSTOMPRouter: STOMPRouter {
  case connectToChatServer
  case disconnectFromChatServer
  case subscribeToChatRoom(roomId: String)
  case unsubsribeFromChatRoom(roomId: String)
  case sendMessage(message: String, roomId: String)
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
  
  public var destination: String {
    switch self {
    case .subscribeToChatRoom(let roomId), .unsubsribeFromChatRoom(let roomId), .sendMessage(_, let roomId):
      return "/topic/chat/\(roomId)"
    default:
      return ""
    }
  }
  
  public var headers: [String : String] {
    var defaultHeaders: [String: String] = ["accept-version": "1.2", "host": "dev.api.chattylab.org"]
    switch self {
    case .connectToChatServer:
      defaultHeaders["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJtb2JpbGVOdW1iZXIiOiIwMTA2MjU4NTA1NSIsImRldmljZUlkIjoiMjE3MDFCMTItQjE3Ni00NjIwLUI0RjUtQjY3NTk3REFGMTJDIiwiaWF0IjoxNzA5MDI4NzYzLCJleHAiOjE3MDkwMjg5NDN9.VnJD6e69oT1T0-JjxnWYUnDsrAYvWcrjFyEykGqZvuM"
    default:
      break
    }
    return defaultHeaders
  }
  
  public var body: String? {
    switch self {
    case .sendMessage(let message, let roomId):
      return message
    default:
      return nil
    }
  }
}
