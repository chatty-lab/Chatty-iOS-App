//
//  ChatMessagesRequestDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation

public struct ChatMessagesRequestDTO: Encodable {
  let roomId: Int
  
  public init(roomId: Int) {
    self.roomId = roomId
  }
}
