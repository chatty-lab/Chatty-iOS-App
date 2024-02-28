//
//  STOMPRouter.swift
//  SharedUtil
//
//  Created by HUNHIE LEE on 2/15/24.
//

import Foundation

public protocol STOMPRouter {
  var command: STOMPCommand { get }
  var destination: String { get }
  var headers: [String: String] { get }
  var body: String? { get }
}

public enum STOMPCommand: String {
  case CONNECT
  case DISCONNECT
  case SUBSCRIBE
  case UNSUBSCRIBE
  case SEND
}
