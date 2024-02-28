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
  public var data: ChatRoomList
  
  public struct ChatRoomList: Decodable {
    let list: [ChatRoomData]
  }
  
  public func toDomain() -> [ChatRoom] {
    return data.list.map {
      ChatRoom(roomId: $0.roomId, senderId: $0.senderId, receiverId: $0.receiverId)
    }
  }
}
