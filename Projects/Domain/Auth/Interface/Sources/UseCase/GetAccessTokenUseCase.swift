//
//  GetAccessTokenUseCase.swift
//  DomainAuthInterface
//
//  Created by HUNHIE LEE on 3/1/24.
//

import Foundation
import RxSwift

public protocol GetAccessTokenUseCase {
  func execute() -> Single<String>
}
