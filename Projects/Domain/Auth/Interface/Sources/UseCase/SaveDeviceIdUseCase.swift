//
//  SaveDeviceIdUseCase.swift
//  DomainAuth
//
//  Created by HUNHIE LEE on 2/8/24.
//

import Foundation
import RxSwift

public protocol SaveDeviceIdUseCase {
  func execute() -> Single<Void>
}
