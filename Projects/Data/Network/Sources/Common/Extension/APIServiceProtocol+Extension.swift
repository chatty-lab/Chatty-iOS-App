//
//  APIServiceProtocol+Extension.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import RxSwift
import DataNetworkInterface

public extension APIServiceProtocol {
  func request<Model: Decodable>(endPoint: Router, responseDTO: Model.Type) -> Single<Model> {
    return provider.rx.request(endPoint)
      .handleResponse(responseDTO: responseDTO)
  }
}
