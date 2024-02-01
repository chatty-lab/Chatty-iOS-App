//
//  UserDefaultsRepositoryProtocol.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol UserDefaultsRepositoryProtocol {
  func requestCreat(type: String)
  func requestRead<T>(type: String) -> Observable<T?>
  func requestDelete(type: String)
}
