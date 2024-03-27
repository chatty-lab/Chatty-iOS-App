//
//  DefaultValidateAccessTokenUseCase.swift
//  DomainAuthInterface
//
//  Created by HUNHIE LEE on 3/1/24.
//

import Foundation
import RxSwift
import DomainAuthInterface
import DomainCommon

public struct DefaultValidateAccessTokenUseCase: ValidateAccessTokenUseCase {
  private let authAPIRepository: AuthAPIRepositoryProtocol
  
  public init(authAPIRepository: AuthAPIRepositoryProtocol) {
    self.authAPIRepository = authAPIRepository
  }
  
  public func execute() -> Single<Bool> {
    return authAPIRepository.tokenValidation()
  }
}
