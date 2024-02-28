//
//  ChatSTOMPService.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/15/24.
//

import Foundation
import RxSwift
import SharedUtil

public enum WebSocketEventResult {
  case text(ChatMessageResponse)
  case connectionChanged(Connection: Bool, errorInfo: (reason: String, code: UInt16)? = nil)
  case error(Error?)
}

public protocol ChatSTOMPService {
  var messageStream: PublishSubject<String> { get }
  var connectionStream: PublishSubject<Bool> { get }
  var errorStream: PublishSubject<Error> { get }
  func request(endPoint: ChatSTOMPRouter) -> Observable<Void>
}
