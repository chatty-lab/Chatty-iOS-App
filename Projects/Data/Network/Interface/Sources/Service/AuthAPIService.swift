//
//  AuthAPIService.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import Moya
import RxSwift

public protocol AuthAPIService: APIServiceProtocol {
  var provider: MoyaProvider<AuthAPIRouter> { get }
  func request<Model: Decodable>(endPoint: AuthAPIRouter, responseDTO: Model.Type) -> Single<Model>
}
