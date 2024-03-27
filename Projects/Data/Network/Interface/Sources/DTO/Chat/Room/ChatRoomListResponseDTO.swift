//
//  ChatRoomListResponseDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation
import DomainChat

public struct ChatRoomListResponseDTO: CommonResponseDTO {
  public var code: Int
  public var status: String
  public var message: String
  public var data: [ChatRoomData]

  public func toDomain() -> [ChatRoom] {
    return data.map {
      ChatRoom(roomId: $0.roomId, senderId: $0.senderId, senderNickname: $0.senderNickname, senderImageURL: $0.senderImageURL, lastMessage: $0.lastMessage, unreadMessageCount: $0.unreadMessageCount, createdAt: $0.createdAt?.toDateFromISO8601())
    }
  }
}
