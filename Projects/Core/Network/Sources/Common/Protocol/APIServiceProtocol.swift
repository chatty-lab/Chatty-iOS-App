//
//  APIServiceProtocol.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/15/24.
//

import Foundation
import Moya
import RxMoya
import RxSwift

/// `ApiServiceProtocol`은 Moya를 사용하여 네트워크 요청을 처리하는 프로토콜입니다.
///
/// __Associated Types__
/// - `Router`: 네트워크 요청을 정의하는데 사용되며, `TargetType` 프로토콜을 준수해야 합니다.
///   이는 API의 엔드포인트, 파라미터 등을 정의합니다.
///
/// __Properties__
/// - `provider`: 네트워크 요청을 보내고 응답을 처리하는 `MoyaProvider<Router>`의 인스턴스입니다.
///
/// __Methods__
/// - `request`: `Router` 엔드포인트를 사용하여 네트워크 요청을 수행합니다. 
///   응답은 `Decodable` 모델로 반환됩니다. 
///   반환 타입은 `Single<Model>`로, RxSwift의 Single Trait을 사용하여 단일 이벤트를 나타냅니다.
///
public protocol APIServiceProtocol {
  associatedtype Router: TargetType
  var provider: MoyaProvider<Router> { get }
  func request<Model: Decodable>(endPoint: Router, responseDTO: Model.Type) -> Single<Model>
}

public extension APIServiceProtocol {
  func request<Model: Decodable>(endPoint: Router, responseDTO: Model.Type) -> Single<Model> {
    return provider.rx.request(endPoint).flatMap { response -> Single<Model> in
      print(response.statusCode)
      do {
        let response = try JSONDecoder().decode(responseDTO.self, from: response.data)
        return Single.just(response)
      } catch {
        do {
          let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: response.data)
          let mappedError = errorResponse.toMappedError()
          return Single.error(mappedError)
        } catch {
          return Single.error(error)
        }
      }
    }
  }
}

