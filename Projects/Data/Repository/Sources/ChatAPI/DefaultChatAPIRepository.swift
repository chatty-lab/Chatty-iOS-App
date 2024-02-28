//
//  DefaultChatAPIRepository.swift
//  DataRepository
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation
import DomainChatInterface
import DataNetworkInterface
import RxSwift

public struct DefaultChatAPIRepository: ChatAPIRepositoryProtocol {
  private let chatAPIService: any ChatAPIService
  
  public init(chatAPIService: any ChatAPIService) {
    self.chatAPIService = chatAPIService
  }
  
  public func fetchChatMessages(roomId: Int) -> Single<[ChatMessageProtocol]> {
    let request = ChatMessagesRequestDTO(roomId: roomId)
    return chatAPIService.request(endPoint: .messages(request), responseDTO: ChatMessagesResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveChatMessage(with message: ChatMessageProtocol) -> Single<Void> {
    return .just(())
  }
  
  public func fetchChatRooms() -> Single<[ChatRoomProtocol]> {
    return chatAPIService.request(endPoint: .getChatRooms, responseDTO: ChatRoomListResponseDTO.self)
      .map { $0.toDomain() }
  }
}
