//
//  ChatMessageProtocol.swift
//  DomainChatInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation

public protocol ChatMessageProtocol {
  var content: MessageContentType { get }
  var senderId: Int { get }
  var sendTime: Date? { get }
  var roomId: Int { get }
}

public enum MessageContentType: Hashable {
  case text(String)
  
  public var textValue: String {
    switch self {
    case .text(let string):
      return string
    }
  }
}
