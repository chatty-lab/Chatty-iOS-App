//
//  MatchSocketResponseDTO.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import DomainLiveInterface

public struct MatchSocketResponseDTO: Decodable {
  let roomId: Int
  let senderId: Int
  let receiverId: Int

  public init(jsonDict: [String: Any]) {
    self.roomId = jsonDict["roomId"] as? Int ?? 0
    self.senderId = jsonDict["senderId"] as? Int ?? 0
    self.receiverId = jsonDict["receiverId"] as? Int ?? 0
  }
  
  public func toDomain() -> MatchSocketResult {
    return MatchSocketResult(
      roomId: self.roomId,
      senderId: self.senderId,
      receiverId: self.receiverId
    )
  }
}
