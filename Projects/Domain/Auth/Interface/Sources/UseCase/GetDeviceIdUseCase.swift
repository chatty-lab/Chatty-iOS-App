//
//  GetDeviceIdUseCase.swift
//  DomainAuthInterface
//
//  Created by HUNHIE LEE on 2/4/24.
//

import Foundation
import RxSwift

public protocol GetDeviceIdUseCase {
  func execute() -> Single<String>
}
