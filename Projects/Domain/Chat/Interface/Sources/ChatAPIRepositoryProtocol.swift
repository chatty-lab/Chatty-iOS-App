//
//  ChatAPIRepositoryProtocol.swift
//  DomainChatInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation
import RxSwift

public protocol ChatAPIRepositoryProtocol {
  func fetchChatMessages(roomId: Int) -> Single<[ChatMessageProtocol]>
  func saveChatMessage(with message: ChatMessageProtocol) -> Single<Void>
  func fetchChatRooms() -> Single<[ChatRoomProtocol]>
}
