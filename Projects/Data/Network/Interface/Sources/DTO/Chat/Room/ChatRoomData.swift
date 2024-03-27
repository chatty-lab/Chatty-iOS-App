//
//  ChatRoomData.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation

public struct ChatRoomData: Decodable {
  let roomId, senderId: Int
  let senderNickname: String
  let senderImageURL: String?
  let blueCheck: Bool
  let createdAt, lastMessage: String?
  let unreadMessageCount: Int
  
  enum CodingKeys: String, CodingKey {
    case roomId
    case senderId
    case senderNickname
    case senderImageURL = "senderImageUrl"
    case blueCheck, createdAt, lastMessage, unreadMessageCount
  }
}
