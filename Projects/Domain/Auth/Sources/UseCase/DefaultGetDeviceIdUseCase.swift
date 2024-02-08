//
//  DefaultGetDeviceIdUseCase.swift
//  DomainAuth
//
//  Created by HUNHIE LEE on 2/4/24.
//

import Foundation
import RxSwift
import DomainCommon
import DomainAuthInterface

public struct DefaultGetDeviceIdUseCase: GetDeviceIdUseCase {
  private let keychainRepository: KeychainReposotoryProtocol
  
  public init(keychainRepository: KeychainReposotoryProtocol) {
    self.keychainRepository = keychainRepository
  }
  
  public func execute() -> Single<String> {
    return keychainRepository.requestRead(type: .deviceId())
  }
}
