//
//  DefaultChatSTOMPRepository.swift
//  DataRepositoryInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import DataNetworkInterface
import DomainChatInterface
import RxSwift

public struct DefaultChatSTOMPRepository: ChatSTOMPRepositoryProtocol {
  private let chatSTOMPService: any ChatSTOMPService
  
  public init(chatSTOMPService: any ChatSTOMPService) {
    self.chatSTOMPService = chatSTOMPService
  }
  
  public func connectToChatSTOMPServer() -> Observable<Void> {
    return chatSTOMPService.request(endPoint: .connectToChatServer)
  }
  
  public func disconnectToChatSTOMPServer() -> Observable<Void> {
    return chatSTOMPService.request(endPoint: .disconnectFromChatServer)
  }
  
  public func sendMessage(message: String, toRoomId roomId: String) -> Observable<Void> {
    return chatSTOMPService.request(endPoint: .sendMessage(message: message, roomId: roomId))
  }
  
  public func subscribeToChatRoom(roomId: String) -> Observable<Void> {
    return chatSTOMPService.request(endPoint: .subscribeToChatRoom(roomId: roomId))
  }
  
  public func unsubscribeFromChatRoom(roomId: String) -> Observable<Void> {
    return chatSTOMPService.request(endPoint: .unsubsribeFromChatRoom(roomId: roomId))
  }
  
  public func observeMessages() -> Observable<String> {
    return chatSTOMPService.messageStream
  }
  
  public func observeConnectionChanges() -> Observable<Bool> {
    return chatSTOMPService.connectionStream
  }
  
  public func observeErrors() -> Observable<Error> {
    return chatSTOMPService.errorStream
  }
}
