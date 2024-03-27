//
//  STOMPProvider.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import RxSwift
import Starscream
import DataStorageInterface
import DataNetworkInterface
import DomainChatInterface
import DomainChat
import SharedUtil
import SwiftStomp

public class ChatSTOMPServiceImpl: ChatSTOMPService, SwiftStompDelegate {
  public static let shared = ChatSTOMPServiceImpl()
  
  let url = URL(string: "wss://dev.api.chattylab.org/ws")!
  
  private let socketStateSubject = PublishSubject<SocketState>()
  private let socketResultSubject = PublishSubject<ChatMessageProtocol>()
  
  lazy var swiftStomp = SwiftStomp(host: url)
  
  private init() {
    swiftStomp.delegate = self
    swiftStomp.autoReconnect = true
  }
  
  public func connectSocket() -> PublishSubject<SocketState> {
    swiftStomp.connect(acceptVersion: "1.1, 1.2")
    return socketStateSubject
  }
  
  public func socketObserver() -> PublishSubject<ChatMessageProtocol> {
    return socketResultSubject
  }
  
  public func send(_ router: ChatSTOMPRouter) {
    
    if swiftStomp.isConnected {
      if let message = router.body as? ChatMessageRequestDTO {
        swiftStomp.send(body: message, to: router.destination, receiptId: router.id, headers: router.headers, jsonDateEncodingStrategy: .iso8601)
      }
    } else {
      swiftStomp.connect()
    }
  }
  
  public func subscribe(to: String) {
    if swiftStomp.isConnected {
      swiftStomp.subscribe(to:"/sub/chat/\(to)")
    } else {
      swiftStomp.connect()
    }
  }
  
  public func onConnect(swiftStomp: SwiftStomp, connectType: StompConnectType) {
    switch connectType {
    case .toSocketEndpoint:
      socketStateSubject.onNext(.socketConnected)
    case .toStomp:
      socketStateSubject.onNext(.stompConnected)
    }
  }
  
  public func onDisconnect(swiftStomp: SwiftStomp, disconnectType: StompDisconnectType) {
    
  }
  
  public func onMessageReceived(swiftStomp: SwiftStomp, message: Any?, messageId: String, destination: String, headers: [String : String]) {
    guard let messageString = message as? String else { return }
    print(messageString)
    if let messageData = messageString.data(using: .utf8) {
      do {
        let decodeMessage = try JSONDecoder().decode(ChatMessageResponseDTO.self, from: messageData)
        let chatMessage = ChatMessage(content: .text(decodeMessage.data.content), senderId: decodeMessage.data.senderID, sendTime: Date(), roomId: decodeMessage.data.roomID)
        socketResultSubject.onNext(chatMessage)
      } catch {
        print("Error decoding message: \(error)")
      }
    }
  }
  
  public func onReceipt(swiftStomp: SwiftStomp, receiptId: String) {
    print(receiptId)
  }
  
  public func onError(swiftStomp: SwiftStomp, briefDescription: String, fullDescription: String?, receiptId: String?, type: StompErrorType) {
    print(fullDescription)
  }
  
  public func onSocketEvent(eventName: String, description: String) {
    print(eventName)
  }
}
