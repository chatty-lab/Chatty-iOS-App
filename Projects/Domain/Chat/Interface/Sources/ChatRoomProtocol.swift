//
//  ChatRoomProtocol.swift
//  DomainChatInterface
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation

public protocol ChatRoomProtocol {
  var roomId: Int { get }
  var senderId: Int { get }
  var receiverId: Int { get }
}
