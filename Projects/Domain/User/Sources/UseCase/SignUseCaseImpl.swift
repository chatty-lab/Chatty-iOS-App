//
//  SignUserCase.swift
//  DomainUser
//
//  Created by 윤지호 on 1/26/24.
//

import Foundation
import DomainUserInterface
import DomainCommonInterface
import RxSwift



public final class DefaultSignUseCase: SignUseCase {
  
  private let userApiRepository: UserApiRepository
  private let keychainReposotory: KeychainReposotory
  
  private let tokenUseCase: TokenUseCaseProtocol
  
  public init(userApiRepository: UserApiRepository, keychainReposotory: KeychainReposotory, tokenUseCase: TokenUseCaseProtocol) {
    self.userApiRepository = userApiRepository
    self.keychainReposotory = keychainReposotory
    self.tokenUseCase = tokenUseCase
  }
  
  /// api 호출에 성공하면 accessToken, refreshToken 을 키체인에 저장합니다
  public func requestLogin(mobileNumber: String, authenticationNumber: String) -> Single<Bool> {
    let deviceTokenObservable = keychainReposotory.requestRead(type: .deviceToken())
    let deviceIdObservable = keychainReposotory.requestRead(type: .deviceId())
    
    return Single.zip(deviceIdObservable, deviceTokenObservable)
      .flatMap { deviceId, deviceToken in
        return self.userApiRepository.login(
          mobileNumber: mobileNumber,
          authenticationNumber: authenticationNumber,
          deviceId: deviceId,
          deviceToken: deviceToken
        )
        .flatMap { tokens -> Single<Bool> in
          let saveAccessToken = self.keychainReposotory.requestCreat(type: .accessToken(tokens.accessToken))
          let saveRefreshToken = self.keychainReposotory.requestCreat(type: .refreshToken(tokens.refreshToken))
          
          return Single.zip(saveAccessToken, saveRefreshToken)
            .map { accessToken, refreshToken  in
              return accessToken && refreshToken
            }
        }
      }
  }
  
  public func requestJoin(mobileNumber: String, authenticationNumber: String) -> Single<Bool> {
    return .just(true)
  }
}
