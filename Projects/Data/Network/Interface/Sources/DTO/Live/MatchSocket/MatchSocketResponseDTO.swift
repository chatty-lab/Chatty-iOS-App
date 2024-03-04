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

  public func toDomain() -> MatchSocketResult {
    return MatchSocketResult(
      roomId: self.roomId,
      senderId: self.senderId,
      receiverId: self.receiverId
    )
  }
}
