//
//  SignUserCase.swift
//  DomainUser
//
//  Created by 윤지호 on 1/26/24.
//

import Foundation
import CoreRepository
import CoreNetwork
import RxSwift

public protocol SignUseCase {
  func requestLogin(mobileNumber: String, authenticationNumber: String) -> Single<Bool>
  func requestJoin(mobileNumber: String, authenticationNumber: String) -> Single<Bool>
}

public final class DefaultSignUseCase: SignUseCase {
  
  private let userApiRepository: UserApiRepositoryProtocol
  private let keychainReposotory: KeychainReposotoryProtocol
  
  private let tokenUseCase: TokenUseCaseProtocol
  
  public init(userApiRepository: UserApiRepositoryProtocol, keychainReposotory: KeychainReposotoryProtocol, tokenUseCase: TokenUseCaseProtocol) {
    self.userApiRepository = userApiRepository
    self.keychainReposotory = keychainReposotory
    self.tokenUseCase = tokenUseCase
  }
  
  /// api 호출에 성공하면 accessToken, refreshToken 을 키체인에 저장합니다
  public func requestLogin(mobileNumber: String, authenticationNumber: String) -> Single<Bool> {
    let deviceTokenObservable = keychainReposotory.requestRead(type: .diviceToken(""))
    let deviceIdObservable = keychainReposotory.requestRead(type: .diviceId(""))
    
    let tokenObservable = Single.zip(deviceIdObservable, deviceTokenObservable) { deviceId, deviceToken -> UserSignRequestDTO in
      let request = UserSignRequestDTO(
        mobileNumber: mobileNumber,
        authenticationNumber: authenticationNumber,
        deviceId: deviceId,
        deviceToken: deviceToken
      )
      return request
    }
    
    return tokenObservable
      .flatMap { request in
        return self.userApiRepository.login(request: request)
          .flatMap { response -> Single<Bool> in
            let saveAccessToken = self.keychainReposotory.requestCreat(type: .accessToken(response.data.accessToken))
            let saveRefreshToken = self.keychainReposotory.requestCreat(type: .refreshToken(response.data.refreshToken))
            
            return Single.zip(saveAccessToken, saveRefreshToken)
              .map { accessToken, refreshToken  in
                return response.status == "OK" ? true : false
              }
          }
      }
  }
  
  public func requestJoin(mobileNumber: String, authenticationNumber: String) -> Single<Bool> {
    let deviceTokenObservable = keychainReposotory.requestRead(type: .diviceToken(""))
    let deviceIdObservable = keychainReposotory.requestRead(type: .diviceId(""))
    
    let tokenObservable = Single.zip(deviceIdObservable, deviceTokenObservable) { deviceId, deviceToken -> UserSignRequestDTO in
      let request = UserSignRequestDTO(
        mobileNumber: mobileNumber,
        authenticationNumber: authenticationNumber,
        deviceId: deviceId,
        deviceToken: deviceToken
      )
      return request
    }
    
    return tokenObservable
      .flatMap { request in
        return self.userApiRepository.login(request: request)
          /// api 호출에 성공하면 accessToken, refreshToken 을 키체인에 저장합니다
          .flatMap { response -> Single<Bool> in
            let saveAccessToken = self.keychainReposotory.requestCreat(type: .accessToken(response.data.accessToken))
            let saveRefreshToken = self.keychainReposotory.requestCreat(type: .refreshToken(response.data.refreshToken))
            
            return Single.zip(saveAccessToken, saveRefreshToken)
              .map { accessToken, refreshToken  in
                return response.status == "OK" ? true : false
              }
          }
      }
  }
}
