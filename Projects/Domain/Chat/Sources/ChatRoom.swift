//
//  ChatRoom.swift
//  DomainChat
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation
import DomainChatInterface

public struct ChatRoom: ChatRoomProtocol {
  public let roomId: Int
  public let senderId: Int
  public let senderNickname: String
  public let senderImageURL: String?
  public let lastMessage: String?
  public let unreadMessageCount: Int?
  public let createdAt: Date?
  
  public init(roomId: Int, senderId: Int, senderNickname: String, senderImageURL: String?, lastMessage: String?, unreadMessageCount: Int?, createdAt: Date?) {
    self.roomId = roomId
    self.senderId = senderId
    self.senderNickname = senderNickname
    self.senderImageURL = senderImageURL
    self.lastMessage = lastMessage
    self.unreadMessageCount = unreadMessageCount
    self.createdAt = createdAt
  }
}
