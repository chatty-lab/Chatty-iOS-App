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
  
  /// 유저데이터를 가져올 수 있는 사
  private let getAllInterestsUseCase: GetAllInterestsUseCase
  
  public init(userAPIRepository: any UserAPIRepositoryProtocol, keychainRepository: any KeychainReposotoryProtocol, getAllInterestsUseCase: GetAllInterestsUseCase) {
    self.userAPIRepository = userAPIRepository
    self.keychainRepository = keychainRepository
    self.getAllInterestsUseCase = getAllInterestsUseCase
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
          
          let getAllInterests = self.getAllInterestsUseCase.execute()
          
          return Single.zip(saveAccessToken, saveRefreshToken, getAllInterests)
            .map { accessToken, refreshToken, _ in
              return accessToken && refreshToken
            }
        }
      }
  }
  
  public func requestJoin(mobileNumber: String, authenticationNumber: String) -> Single<Bool> {
    let deviceTokenObservable = keychainRepository.requestRead(type: .deviceToken())
    let deviceIdObservable = keychainRepository.requestRead(type: .deviceId())
    
    return Single.zip(deviceIdObservable, deviceTokenObservable)
      .flatMap { deviceId, deviceToken in
        return self.userAPIRepository.join(
          mobileNumber: mobileNumber,
          authenticationNumber: authenticationNumber,
          deviceId: deviceId,
          deviceToken: deviceToken
        )
        .flatMap { tokens -> Single<Bool> in
          let saveAccessToken = self.keychainRepository.requestCreate(type: .accessToken(tokens.accessToken))
          let saveRefreshToken = self.keychainRepository.requestCreate(type: .refreshToken(tokens.refreshToken))
          
          let getAllInterests = self.getAllInterestsUseCase.execute()
          
          return Single.zip(saveAccessToken, saveRefreshToken, getAllInterests)
            .map { accessToken, refreshToken, _ in
              return accessToken && refreshToken
            }
        }
      }
  }
}
