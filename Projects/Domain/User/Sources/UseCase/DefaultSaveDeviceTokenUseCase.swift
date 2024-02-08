//
//  DefaultSaveDeviceTokenUseCase.swift
//  DomainUser
//
//  Created by HUNHIE LEE on 2/4/24.
//

import Foundation
import RxSwift
import DomainCommon
import DomainUserInterface

public struct DefaultSaveDeviceTokenUseCase: SaveDeviceTokenUseCaseProtocol {
  private let keychainRepository: KeychainReposotoryProtocol
  
  public init(keychainRepository: KeychainReposotoryProtocol) {
    self.keychainRepository = keychainRepository
  }
  
  public func execute(deviceToken: String) -> Single<Bool> {
    return keychainRepository.requestCreate(type: .deviceToken(deviceToken))
  }
}
