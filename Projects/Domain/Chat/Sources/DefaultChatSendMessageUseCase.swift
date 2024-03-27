//
//  DefaultChatSendMessageUseCase.swift
//  DomainChatInterface
//
//  Created by HUNHIE LEE on 3/7/24.
//

import Foundation
import RxSwift
import DomainChatInterface

public struct DefaultChatSendMessageUseCase {
  private let chatSTOMPRepository: ChatSTOMPRepositoryProtocol
  
  public init(chatSTOMPRepository: ChatSTOMPRepositoryProtocol) {
    self.chatSTOMPRepository = chatSTOMPRepository
  }
  
  public func execute(roomId: Int, content: String, senderId: Int) {
    return chatSTOMPRepository.sendMessage(roomdId: roomId, .text(content))
  }
}
