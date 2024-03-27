//
//  DefaultGetAccessTokenUseCase.swift
//  DomainAuthInterface
//
//  Created by HUNHIE LEE on 3/1/24.
//

import Foundation
import RxSwift
import DomainAuthInterface
import DomainCommon

public struct DefaultGetAccessTokenUseCase: GetAccessTokenUseCase {
  private let keychainRepository: KeychainReposotoryProtocol
  
  public init(keychainRepository: KeychainReposotoryProtocol) {
    self.keychainRepository = keychainRepository
  }
  
  public func execute() -> Single<String> {
    return keychainRepository.requestRead(type: .accessToken(""))
  }
}
