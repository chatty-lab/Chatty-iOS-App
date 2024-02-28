//
//  ChatMessageViewData.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import DomainChatInterface

public struct ChatMessageViewData: Hashable {
  public let content: MessageContentType
  public let senderType: ChatParticipantType
  public let sendTime: Date
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(content)
    hasher.combine(senderType)
    hasher.combine(sendTime)
  }
  
  public static func == (lhs: ChatMessageViewData, rhs: ChatMessageViewData) -> Bool {
    return lhs.content == rhs.content
    && lhs.senderType == rhs.senderType
    && lhs.sendTime == rhs.sendTime
  }
  
  public init(content: MessageContentType, senderType: ChatParticipantType, timestamp: Date) {
    self.content = content
    self.senderType = senderType
    self.sendTime = timestamp
  }
}
