//
//  FeatureChatDependecyProvider.swift
//  FeatureChatInterface
//
//  Created by HUNHIE LEE on 2/16/24.
//

import Foundation
import DomainChat

public protocol FeatureChatDependecyProvider {
  func makeChatServerConnectUseCase() -> DefaultChatSTOMPConnectUseCase
  func makeGetChatRoomListUseCase() -> DefaultGetChatRoomListUseCase
}
