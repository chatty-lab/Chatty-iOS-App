//
//  PostChatRoomRequestDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation

public struct PostChatRoomRequestDTO: Encodable {
  let senderId: Int
  let reveiverId: Int
  
  public init(senderId: Int, reveiverId: Int) {
    self.senderId = senderId
    self.reveiverId = reveiverId
  }
}
