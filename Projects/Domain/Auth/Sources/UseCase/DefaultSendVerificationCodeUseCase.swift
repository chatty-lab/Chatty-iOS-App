//
//  DefaultSendVerificationCodeUseCase.swift
//  DomainAuth
//
//  Created by HUNHIE LEE on 2/2/24.
//

import Foundation
import DomainAuthInterface
import DomainCommon
import RxSwift

public struct DefaultSendVerificationCodeUseCase: SendVerificationCodeUseCase {
  private let authAPIRepository: AuthAPIRepositoryProtocol
  private let keychainRepository: KeychainReposotoryProtocol
  
  public init(authAPIRepository: AuthAPIRepositoryProtocol, keychainRepository: KeychainReposotoryProtocol) {
    self.authAPIRepository = authAPIRepository
    self.keychainRepository = keychainRepository
  }
  
  public func execute(mobileNumber: String) -> Single<Void> {
    return keychainRepository.requestRead(type: .deviceId())
      .flatMap { deviceId in
        return authAPIRepository.sendVerificationCode(mobileNumber: mobileNumber, deviceId: deviceId)
      }
  }
}
