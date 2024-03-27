//
//  ChatMessageRequestDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 3/13/24.
//

import Foundation

public struct ChatMessageRequestDTO: Encodable {
  let roomId: Int
  let senderId: Int
  let receiverId: Int
  let content: String
  
  public init(roomId: Int, senderId: Int, receiverId: Int, content: String) {
    self.roomId = roomId
    self.senderId = senderId
    self.receiverId = receiverId
    self.content = content
  }
  
  var dictValue: [String: Any]? {
    return [
      "roomId": roomId,
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content
    ]
  }
}
