//
//  ChatMessage.swift
//  FeatureChatInterface
//
//  Created by HUNHIE LEE on 2/9/24.
//

import Foundation
import DomainChatInterface

public struct ChatMessage: ChatMessageProtocol {
  public let content: MessageContentType
  public let senderId: Int
  public let sendTime: Date?
  public var roomId: Int
  
  public init(content: MessageContentType, senderId: Int, sendTime: Date?, roomId: Int) {
    self.content = content
    self.senderId = senderId
    self.sendTime = sendTime
    self.roomId = roomId
  }
}

