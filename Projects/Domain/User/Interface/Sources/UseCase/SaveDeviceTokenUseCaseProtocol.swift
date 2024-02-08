//
//  SaveDeviceTokenUseCaseProtocol.swift
//  DomainUserInterface
//
//  Created by HUNHIE LEE on 2/4/24.
//

import Foundation
import RxSwift

public protocol SaveDeviceTokenUseCaseProtocol {
  func execute(deviceToken: String) -> Single<Bool>
}
