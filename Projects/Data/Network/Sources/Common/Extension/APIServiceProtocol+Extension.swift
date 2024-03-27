//
//  APIServiceProtocol+Extension.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import RxSwift
import DataNetworkInterface
import DomainCommon

public extension APIServiceProtocol {
  func request<Model: Decodable>(endPoint: Router, responseDTO: Model.Type) -> Single<Model> {
    return provider.rx.request(endPoint)
      .handleResponse(responseDTO: responseDTO)
      .retry { errorObservable -> Observable<Single<Void>.Element> in
        errorObservable.flatMap { error -> Single<Void> in
          if let error = error as? NetworkError {
            switch error.errorCase {
            case .E002AccessTokenExpired:
              return self.refreshToken()
            default:
              return Single.error(error)
            }
          } else {
            return Single.error(error)
          }
        }
      }
  }
}
