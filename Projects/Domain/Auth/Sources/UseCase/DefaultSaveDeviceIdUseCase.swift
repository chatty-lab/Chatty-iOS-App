//
//  DefaultSaveDeviceIdUseCase.swift
//  DomainAuth
//
//  Created by HUNHIE LEE on 2/8/24.
//

import Foundation
import RxSwift
import DomainCommon
import DomainAuthInterface

public struct DefaultSaveDeviceIdUseCase: SaveDeviceIdUseCase {
  private let keychainRepository: KeychainReposotoryProtocol
  
  public init(keychainRepository: KeychainReposotoryProtocol) {
    self.keychainRepository = keychainRepository
  }
  
  public func execute() -> Single<Void> {
    let newDeviceId = UUID().uuidString
    print("디바이스 아이디 생성 \(newDeviceId)")
    return keychainRepository.requestCreate(type: .deviceId(newDeviceId))
      .map { _ in () }
  }
}
