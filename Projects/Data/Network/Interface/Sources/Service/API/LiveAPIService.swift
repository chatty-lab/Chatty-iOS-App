//
//  LiveAPIService.swift
//  DataNetwork
//
//  Created by 윤지호 on 2/3/24.
//

import Foundation
import Moya
import RxSwift

public protocol LiveAPIService: APIServiceProtocol {
  var provider: MoyaProvider<LiveAPIRouter> { get }
  func request<Model: Decodable>(endPoint: LiveAPIRouter, responseDTO: Model.Type) -> Single<Model>
}
