//
//  ChatMessageResponseDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 3/13/24.
//

import Foundation

public struct ChatMessageResponseDTO: CommonResponseDTO {
  public var code: Int
  public var status: String
  public var message: String
  public var data: DataClass
}

public struct DataClass: Codable {
  public let messageID, roomID, senderID, receiverID: Int
  public let content: String
  
  enum CodingKeys: String, CodingKey {
    case messageID = "messageId"
    case roomID = "roomId"
    case senderID = "senderId"
    case receiverID = "receiverId"
    case content
  }
}
