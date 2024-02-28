//
//  DeleteChatRoomRequestDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation

public struct DeleteChatRoomRequestDTO: Encodable {
  let roomId: Int
  let userId: Int
  
  public init(roomId: Int, userId: Int) {
    self.roomId = roomId
    self.userId = userId
  }
}
