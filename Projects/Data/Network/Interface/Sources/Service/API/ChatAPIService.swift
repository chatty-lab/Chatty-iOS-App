//
//  ChatAPIServiceProtocol.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/13/24.
//

import Foundation
import Moya
import RxSwift

public protocol ChatAPIService: APIServiceProtocol {
  var provider: MoyaProvider<ChatAPIRouter> { get }
  func request<Model: Decodable>(endPoint: ChatAPIRouter, responseDTO: Model.Type) -> Single<Model>
}
