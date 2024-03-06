//
//  ProfileAPIServiceImpl.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation
import Moya
import DataNetworkInterface

public final class ProfileAPIServiceImpl: ProfileAPIService {
  public typealias Router = ProfileAPIRouter
  public var provider: MoyaProvider<ProfileAPIRouter> = .init(plugins: [
    MoyaLoggingPlugin(),
    AccessTokenPlugin { target in
      let accesstoken = "accesstoken"
      return accesstoken
    }
  ])
  public init() { }
}
