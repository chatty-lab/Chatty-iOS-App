//
//  DefaultChatSTOMPConnectUseCase.swift
//  DomainChat
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import RxSwift
import DomainChatInterface

public struct DefaultChatSTOMPConnectUseCase {
  private let chatSTOMPRepository: ChatSTOMPRepositoryProtocol
  
  public init(chatSTOMPRepository: ChatSTOMPRepositoryProtocol) {
    self.chatSTOMPRepository = chatSTOMPRepository
  }
  
  public func execute() -> Observable<Void> {
    return chatSTOMPRepository.connectToChatSTOMPServer()
  }
}
