//
//  ChatMessagesResponseDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import DomainChat
import SharedUtil

public struct ChatMessagesResponseDTO: CommonResponseDTO {
  public let code: Int
  public let status: String
  public let message: String
  public let data: ChatMessagesResponse
  
  public struct ChatMessagesResponse: Decodable {
    let contents: [ChatMessageResponse]
  }
  
  public func toDomain() -> [ChatMessage] {
    self.data.contents.map {
      ChatMessage(content: .text($0.content), senderId: $0.senderId, sendTime: $0.sendTime.toDateFromISO8601(), roomId: $0.roomId)
    }
  }
}

public struct ChatMessageResponse: Decodable {
  let messageId: Int
  let content: String
  let sendTime: String
  let senderId: Int
  let receiverId: Int
  let roomId: Int
}
