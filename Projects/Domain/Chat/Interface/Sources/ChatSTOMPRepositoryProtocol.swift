//
//  ChatSocketRepositoryProtocol.swift
//  DomainChatInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import RxSwift

public protocol ChatSTOMPRepositoryProtocol {
  func connectToChatSTOMPServer() -> Observable<Void>
  func disconnectToChatSTOMPServer() -> Observable<Void>
  func sendMessage(message: String, toRoomId roomId: String) -> Observable<Void>
  func subscribeToChatRoom(roomId: String) -> Observable<Void>
  func unsubscribeFromChatRoom(roomId: String) -> Observable<Void>
  func observeMessages() -> Observable<String>
  func observeConnectionChanges() -> Observable<Bool>
  func observeErrors() -> Observable<Error>
}
