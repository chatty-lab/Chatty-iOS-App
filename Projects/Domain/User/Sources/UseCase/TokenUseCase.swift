//
//  TokenUserCase.swift
//  DomainUser
//
//  Created by 윤지호 on 1/27/24.
//

import Foundation
import CoreRepository
import CoreNetwork
import RxSwift

public protocol TokenUseCaseProtocol {
  func saveToken(accessToken: String, refreshToken: String) -> Single<Bool>
  func requestAccessToken() -> Single<String>
  func requestTokenRefresh() -> Single<String>
  func requestDeviceToken()
  func requestDeviceId()
}

public final class DefaultTokenUseCase: TokenUseCaseProtocol {
  
  private let keychainRepository: KeychainReposotoryProtocol
  private let authAPIRepository: AuthApiRepositoryProtocol
  
  public init(keychainRepository: KeychainReposotoryProtocol, authAPIRepository: AuthApiRepositoryProtocol) {
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
    let accessTokenObserverable = keychainRepository.requestRead(type: .accessToken(""))
      
    return accessTokenObserverable
  }
  
  public func requestTokenRefresh() -> Single<String> {
    return keychainRepository.requestRead(type: .refreshToken())
      .flatMap { [weak self] refreshToken -> Single<TokenResponseDTO> in
        guard let self = self else { return .error(NSError(domain: "self empty", code: -1)) }
        let request = RefreshRequestDTO(refreshToken: refreshToken)
        return self.authAPIRepository.requestTokenRefresh(request: request)
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
