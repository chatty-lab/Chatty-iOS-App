//
//  MatchResult.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 2/13/24.
//

import Foundation

public struct MatchSocketResult {
  let roomId: Int
  let senderId: Int
  let receiverId: Int
  
  public init(roomId: Int, senderId: Int, receiverId: Int) {
    self.roomId = roomId
    self.senderId = senderId
    self.receiverId = receiverId
  }
}
