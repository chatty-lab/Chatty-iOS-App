//
//  GetUserDataUseCase.swift
//  DomainUserInterface
//
//  Created by HUNHIE LEE on 2/3/24.
//

import Foundation
import RxSwift

public protocol GetUserDataUseCase {
  func execute(hasFetched: Bool) -> Single<UserDataProtocol>
  func execute() -> UserDataProtocol
}
