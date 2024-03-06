//
//  UserAPIService.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import Moya
import RxSwift

public protocol UserAPIService: APIServiceProtocol {
  var provider: MoyaProvider<UserAPIRouter> { get }
  func request<Model: Decodable>(endPoint: UserAPIRouter, responseDTO: Model.Type) -> Single<Model>
}
