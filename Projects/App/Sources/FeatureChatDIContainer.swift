//
//  FeatureChatDIContainer.swift
//  Chatty
//
//  Created by HUNHIE LEE on 2/16/24.
//

import Foundation
import FeatureChatInterface
import DomainChat
import DataRepository
import DataNetwork
import DataStorage

final class FeatureChatDIContainer: FeatureChatDependecyProvider {
  func makeGetChatRoomListUseCase() -> DomainChat.DefaultGetChatRoomListUseCase {
    return DefaultGetChatRoomListUseCase(chatAPIRepository: makeChatAPIRepository())
  }
  
  func makeChatServerConnectUseCase() -> DefaultChatSTOMPConnectUseCase {
    return DefaultChatSTOMPConnectUseCase(chatSTOMPRepository: makeChatSTOMPRepository())
  }
}

extension FeatureChatDIContainer {
  func makeChatSTOMPRepository() -> DefaultChatSTOMPRepository {
    return DefaultChatSTOMPRepository(chatSTOMPService: ChatSTOMPServiceImpl())
  }
  
  func makeChatAPIRepository() -> DefaultChatAPIRepository {
    return DefaultChatAPIRepository(
      chatAPIService: ChatAPIServiceImpl(
        authAPIService: AuthAPIServiceImpl(
          keychainService: KeychainService.shared
        ),
        keychainService: KeychainService.shared)
    )
  }
}
