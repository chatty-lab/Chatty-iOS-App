//
//  ApiServiceProtocol.swift
//  CoreNetwork
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation
import RxSwift
import Moya
import RxMoya
import Alamofire

protocol ApiServiceProtocol {
  associatedtype Router: TargetType
  var provider: MoyaProvider<Router> { get set }
  func request<Model: Decodable>(endPoint: Router, returnModel: Model.Type) -> Single<Model>
}

extension ApiServiceProtocol {
  func request<Model: Decodable>(endPoint: Router, returnModel: Model.Type) -> Single<Model> {
    provider.rx.request(endPoint).flatMap { response -> Single<Model> in
      do {
        let data = try JSONDecoder().decode(returnModel.self, from: response.data)
        return Single.just(data)
      } catch(let decodeError) {
        return Single.error(decodeError)
      }
    }
  }
}

