//
//  ChatAPIRouter.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation
import Moya

public enum ChatAPIRouter: RouterProtocol {
  case messages(ChatMessagesRequestDTO)
  case createChatRoom(senderId: Int, receiverId: Int)
  case deleteChatRoom(roomId: Int, userId: Int)
  case getChatRoomInfo(roomId: Int)
  case getChatRooms
}

public extension ChatAPIRouter {
  var baseURL: URL {
    return URL(string: Environment.baseURL + basePath)!
  }
  
  var basePath: String {
    return "/chat"
  }
  
  var path: String {
    switch self {
    case .messages:
      return "/messages"
    case .createChatRoom, .deleteChatRoom:
      return "/room"
    case .getChatRoomInfo(let roomId):
      return "/room/\(roomId)"
    case .getChatRooms:
      return "/rooms"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .messages, .createChatRoom:
      return .post
    case .deleteChatRoom:
      return .delete
    case .getChatRoomInfo:
      return .get
    case .getChatRooms:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .messages(let request):
      let param = ["roomId": request.roomId]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .createChatRoom(let senderId, let receiverId):
      let param = ["senderId": senderId, "receiverId": receiverId]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .deleteChatRoom(let roomId, let userId):
      let param = ["roomId": roomId, "userId": userId]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .getChatRoomInfo:
      return .requestPlain
    case .getChatRooms:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .messages, .createChatRoom, .deleteChatRoom, .getChatRoomInfo, .getChatRooms:
      return RequestHeader.getHeader([.json])
    }
  }
  
  var authorizationType: Moya.AuthorizationType? {
    switch self {
    case .messages, .createChatRoom, .deleteChatRoom, .getChatRoomInfo, .getChatRooms:
      return .bearer
    }
  }
}

