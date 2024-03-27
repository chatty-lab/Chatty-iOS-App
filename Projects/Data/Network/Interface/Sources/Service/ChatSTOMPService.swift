//
//  ChatSTOMPService.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/15/24.
//

import Foundation
import RxSwift
import DataStorageInterface
import DomainChatInterface

public protocol ChatSTOMPService {
  func connectSocket() -> PublishSubject<SocketState>
  func socketObserver() -> PublishSubject<ChatMessageProtocol>
  func send(_ router: ChatSTOMPRouter)
  func subscribe(to: String)
}
