//
//  InterestAPIService.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 3/7/24.
//

import Foundation
import Moya
import RxSwift

public protocol InterestAPIService: APIServiceProtocol {
  var provider: MoyaProvider<InterestAPIRouter> { get }
  func request<Model: Decodable>(endPoint: InterestAPIRouter, responseDTO: Model.Type) -> Single<Model>
}
