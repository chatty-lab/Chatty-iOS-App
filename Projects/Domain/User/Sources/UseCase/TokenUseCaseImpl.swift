//
//  TokenUserCase.swift
//  DomainUser
//
//  Created by 윤지호 on 1/27/24.
//

import Foundation
import DomainUserInterface
import DomainCommonInterface
import RxSwift

public final class DefaultTokenUseCase: TokenUseCaseProtocol {
  
  private let keychainRepository: KeychainReposotory
  private let authAPIRepository: AuthApiRepository
  
  public init(keychainRepository: KeychainReposotory, authAPIRepository: AuthApiRepository) {
    self.keychainRepository = keychainRepository
    self.authAPIRepository = authAPIRepository
  }
  
  public func saveToken(accessToken: String, refreshToken: String) -> Single<Bool> {
    let saveAccessToken = keychainRepository.requestCreat(type: .accessToken(accessToken))
    let saveRefreshToken = keychainRepository.requestCreat(type: .accessToken(refreshToken))

    return Single.zip(saveAccessToken, saveRefreshToken) { isSuccessSaveAccess, isSuccessSaveRefresh in
      return isSuccessSaveAccess && isSuccessSaveRefresh
    }
  }
  
  public func requestAccessToken() -> Single<String> {
    return keychainRepository.requestRead(type: .accessToken())
  }
  
  public func requestTokenRefresh() -> Single<String> {
    return keychainRepository.requestRead(type: .refreshToken())
      .flatMap { [weak self] refreshToken -> Single<Token> in
        guard let self = self else { return .error(NSError(domain: "self empty", code: -1)) }
        return self.authAPIRepository.requestTokenRefresh(refreshToken: refreshToken)
      }
      .flatMap { [weak self] response -> Single<String> in
        guard let self = self else { return .error(NSError(domain: "self empty", code: -1)) }
        let saveTokenResponse = self.saveToken(accessToken: response.accessToken, refreshToken: response.refreshToken)
        
        return saveTokenResponse
          .flatMap { _ -> Single<String> in
            return self.requestAccessToken()
          }
      }
  }
  
  public func requestDeviceToken() {
    
  }
  
  public func requestDeviceId() {
    
  }
  
  
}
