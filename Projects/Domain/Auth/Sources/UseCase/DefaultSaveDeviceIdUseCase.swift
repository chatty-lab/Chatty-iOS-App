//
//  DefaultSaveDeviceIdUseCase.swift
//  DomainAuth
//
//  Created by HUNHIE LEE on 2/8/24.
//

import Foundation
import RxSwift
import DomainCommon

public struct DefaultSaveDeviceIdUseCase: SaveDeviceIdUseCase {
  private let keychainRepository: KeychainReposotoryProtocol
  
  public init(keychainRepository: KeychainReposotoryProtocol) {
    self.keychainRepository = keychainRepository
  }
  
  public func execute() -> Single<Void> {
    let newDeviceId = UUID().uuidString
    print(newDeviceId)
    return keychainRepository.requestCreate(type: .deviceId(newDeviceId))
      .map { _ in () }
  }
}
