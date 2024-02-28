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
  public let receiverId: Int
  
  public init(roomId: Int, senderId: Int, receiverId: Int) {
    self.roomId = roomId
    self.senderId = senderId
    self.receiverId = receiverId
  }
}
