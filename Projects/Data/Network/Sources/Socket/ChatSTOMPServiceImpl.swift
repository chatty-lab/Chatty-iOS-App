//
//  ChatSTOMPServiceImpl.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import DataNetworkInterface
import Starscream
import RxSwift
import Shared

public struct ChatSTOMPServiceImpl: ChatSTOMPService {
  public typealias Router = ChatSTOMPRouter
  private let provider: STOMPProvider = STOMPProvider.shared

  public init() { }
  
  public var messageStream: PublishSubject<String> {
    return provider.messageReceived
  }
  
  public var connectionStream: PublishSubject<Bool> {
    return provider.connectionStatusChanged
  }
  
  public var errorStream: PublishSubject<Error> {
    return provider.errorOccurred
  }
  
  public func request(endPoint: ChatSTOMPRouter) -> Observable<Void> {
    return provider.send(endPoint)
  }
}
