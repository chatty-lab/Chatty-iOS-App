//
//  ChatRoomResponseDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation

public struct ChatRoomResponseDTO: CommonResponseDTO {
  public var code: Int
  public var status: String
  public var message: String
  public var data: ChatRoomData
}
