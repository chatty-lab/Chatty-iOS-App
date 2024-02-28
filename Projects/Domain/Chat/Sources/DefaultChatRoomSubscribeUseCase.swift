//
//  DefaultChatRoomSubscribeUseCase.swift
//  DomainChat
//
//  Created by HUNHIE LEE on 2/16/24.
//

import Foundation
import RxSwift
import DomainChatInterface

public struct DefaultChatRoomSubscribeUseCase {
  private let chatSTOMPRepository: ChatSTOMPRepositoryProtocol
  
  public init(chatSTOMPRepository: ChatSTOMPRepositoryProtocol) {
    self.chatSTOMPRepository = chatSTOMPRepository
  }
  
  public func execute(roomId: String) -> Observable<Void> {
    return chatSTOMPRepository.subscribeToChatRoom(roomId: roomId)
  }
}
