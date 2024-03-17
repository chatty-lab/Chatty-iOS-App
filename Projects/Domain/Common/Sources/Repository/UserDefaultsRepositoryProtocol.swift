//
//  UserDefaultsRepositoryProtocol.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol UserDefaultsRepositoryProtocol {
  func requestCreate(type: UserDefaultsCase)
  func requestRead<T>(type: UserDefaultsCase) -> T?
  func requestDelete(type: UserDefaultsCase)
}
