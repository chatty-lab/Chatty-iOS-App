//
//  HandleResponse.swift
//  CoreNetwork
//
//  Created by 윤지호 on 1/28/24.
//

import Foundation
import RxSwift
import Moya
import DataNetworkInterface

/// PrimitiveSequence에 extension으로 Api Reqeust를 정의한 코드입니다.
/// https://gist.github.com/hsleedevelop/edf8fa03ca5c3a1ec2e2878d361ffd7b 을 참고했습니다.

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
  func handleResponse<Model: Decodable>(responseDTO: Model.Type) -> Single<Model> {
    return flatMap { response in
      // 토큰 재발급 받았을 때 토큰 변경함
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
  

  /// 추후  Response가 Token 만료 Error인 경우 Core내에서 Refresh를 해주기위한 코드 진행사항입니다.
//  func handleRefreshToken<Model: Decodable>(responseDTO: Model.Type) -> Single<Model> {
//    return flatMap { response in
//      // 토큰 재발급 받았을 때 토큰 변경함
//      
//      if let newTokenResponse = try? response.map(RefreshResponseDTO.self) {
//        let token = newTokenResponse.data
//        
//        let keychaingService = KeychainService()
//        let saveAccessToken = keychaingService.creat(type: .accessToken(token.accesToken), isForce: true)
//        let saveRefreshToken = keychaingService.creat(type: .refreshToken(token.refreshToken), isForce: true)
//        
//        return Observable.zip(saveAccessToken, saveRefreshToken)
//          .flatMap { _ in
//            return Single.just(newTokenResponse)
//          }
//      }
//      
//      do {
//        let response = try JSONDecoder().decode(responseDTO.self, from: response.data)
//        return Single.just(response)
//      } catch {
//        do {
//          let errorResponse = try JSONDecoder().decode(ErrorResponseDTO.self, from: response.data)
//          let mappedError = errorResponse.toMappedError()
//          return Single.error(mappedError)
//        } catch {
//          return Single.error(error)
//        }
//      }
//    }
//  }
  
  /// APIServiceProtocol 에들어갈 request 코드 진행사항 입니다.
  
//    func request2<Model: Decodable>(endPoint: Router, responseDTO: Model.Type) -> Observable<Model> {
//      return provider.rx.request(endPoint)
//        .handleRefreshToken()
//        .retry(when: { errorObservable in
//          errorObservable
//            .flatMap { error -> Observable<Model> in
//              if let error = error as? NetworkError {
//                switch error.errorCase {
  //                case .E002AccessTokenExpired:
  //                  return AuthAPIService().request(endPoint: <#T##AuthAPIRouter#>, responseDTO: <#T##Decodable.Protocol#>)
  //                default:
  //
  //                }
  //              }
  //            }
  //        })
  //        .retry(1)
  //        .asObservable()
}


