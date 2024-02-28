//
//  ChatAPIServiceImpl.swift
//  DataNetwor
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation
import Moya
import DataNetworkInterface

public final class ChatAPIServiceImpl: ChatAPIService {
  public typealias Router = ChatAPIRouter
  public var provider: MoyaProvider<ChatAPIRouter> = .init(plugins: [
    MoyaLoggingPlugin(),
    AccessTokenPlugin { target in
      let accesstoken = "accesstoken"
      return accesstoken
    }
  ])
  public init() { }
}
