//
//  ChatRoomViewData.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/23/24.
//

import Foundation

public struct ChatRoomViewData: Hashable {
  public let roomId: Int
  public let recieverProfile: ProfileData
  public let lastMessage: ChatMessageViewData
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(roomId)
  }
  
  public static func ==(lhs: ChatRoomViewData, rhs: ChatRoomViewData) -> Bool {
    return lhs.roomId == rhs.roomId
  }
  
  public init(roomId: Int, recieverProfile: ProfileData, lastMessage: ChatMessageViewData) {
    self.roomId = roomId
    self.recieverProfile = recieverProfile
    self.lastMessage = lastMessage
  }
}
