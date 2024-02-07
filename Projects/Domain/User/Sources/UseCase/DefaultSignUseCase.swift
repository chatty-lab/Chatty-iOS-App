//
//  SignUserCase.swift
//  DomainUser
//
//  Created by 윤지호 on 1/26/24.
//

import Foundation
import DomainUserInterface
import DomainCommon
import RxSwift

public final class DefaultSignUseCase: SignUseCase {
  
  private let userAPIRepository: any UserAPIRepositoryProtocol
  private let keychainRepository: any KeychainReposotoryProtocol
  
  public init(userAPIRepository: any UserAPIRepositoryProtocol, keychainReposotory: any KeychainReposotoryProtocol) {
    self.userAPIRepository = userAPIRepository
    self.keychainRepository = keychainReposotory
  }
  
  /// api 호출에 성공하면 accessToken, refreshToken 을 키체인에 저장합니다
  public func requestLogin(mobileNumber: String, authenticationNumber: String) -> Single<Bool> {
    let deviceTokenObservable = keychainRepository.requestRead(type: .deviceToken())
    let deviceIdObservable = keychainRepository.requestRead(type: .deviceId())
    
    return Single.zip(deviceIdObservable, deviceTokenObservable)
      .flatMap { deviceId, deviceToken in
        return self.userAPIRepository.login(
          mobileNumber: mobileNumber,
          authenticationNumber: authenticationNumber,
          deviceId: deviceId,
          deviceToken: deviceToken
        )
        .flatMap { tokens -> Single<Bool> in
          let saveAccessToken = self.keychainRepository.requestCreate(type: .accessToken(tokens.accessToken))
          let saveRefreshToken = self.keychainRepository.requestCreate(type: .refreshToken(tokens.refreshToken))
          
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
