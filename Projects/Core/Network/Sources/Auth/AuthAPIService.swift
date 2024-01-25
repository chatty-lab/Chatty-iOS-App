//
//  APIManager.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/14/24.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol APIService {
  associatedtype Router: TargetType
  
  var provider: MoyaProvider<Router> { get }
  func request<Model: Decodable>(endPoint: Router, returnModel: Model.Type) -> Single<Model>
}

//extension APIService {
//  func request<Model: Decodable>(endPoint: Router, returnModel: Model.Type) -> Single<Model> {
//    provider.rx.request(endPoint).flatMap { response -> Single<Model> in
//      do {
//        let data = try JSONDecoder().decode(returnModel.self, from: response.data)
//        return Single.just(data)
//      } catch {
//        do {
//          let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: response.data)
//          return Single.error(errorResponse)
//        } catch(let decodeError) {
//          return Single.error(decodeError)
//        }
//      }
//    }
//  }
//}
//
//class AuthAPIService: APIService {
//  var provider: Moya.MoyaProvider<AuthAPIRouter> = .init()
//  typealias Router = AuthAPIRouter
//}
