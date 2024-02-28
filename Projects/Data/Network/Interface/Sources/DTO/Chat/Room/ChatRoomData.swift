//
//  ChatRoomData.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation

public struct ChatRoomData: Decodable {
  let roomId: Int
  let senderId: Int
  let receiverId: Int
}
