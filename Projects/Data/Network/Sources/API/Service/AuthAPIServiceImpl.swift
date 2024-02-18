//
//  AuthAPIServiceImpl.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 1/15/24.
//

import Foundation
import DataNetworkInterface
import DataStorageInterface

import Moya
import RxSwift

public final class AuthAPIServiceImpl: AuthAPIService {
  public typealias Router = AuthAPIRouter
  public let provider: MoyaProvider<AuthAPIRouter>
  
  private let keychainService: KeychainServiceProtocol
  
  public init(keychainService: KeychainServiceProtocol) {
    self.keychainService = keychainService
    self.provider = .init(plugins: [
      MoyaPlugin(keychainService: keychainService)
    ])
  }
}

extension AuthAPIServiceImpl {
  /// 1. keychaingService에서 refreshToken을 가져옵니다.
  /// 2. refresh API Request를 받아옵니다.
  public func refreshToken() -> Single<Void> {
    guard let refreshToken = keychainService.read(type: .refreshToken()) else { return .just(())}
    let request = RefreshRequestDTO(refreshToken: refreshToken)
    return self.request(endPoint: .refresh(request), responseDTO: RefreshResponseDTO.self)
      .flatMap { response -> Single<Void> in
        /// 3. 새로받은 accessToken과 refreshToken을 keychainService에 저장합니다.
        let saveAccessToken = self.keychainService.createSingle(type: .accessToken(response.data.accessToken), isForce: true)
        let saveRefreshToken = self.keychainService.createSingle(type: .refreshToken(response.data.refreshToken), isForce: true)
        return Single.zip(saveAccessToken, saveRefreshToken)
          .map { accessToken, refreshToken  in
            print("refreshToken result --> \(accessToken) / \(refreshToken)")
            return ()
          }
      }
  }
  
  /// accessToken 유효성 확인 / Socket request시 사용
  public func validateTokens() {
    
  }
}
