//
//  UserDefaultsRepository.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainCommonInterface
import RxSwift

public protocol UserDefaultsRepositoryProtocol: UserDefaultsRepository {
  func requestCreat(type: String)
  func requestRead<T>(type: String) -> Observable<T?>
  func requestDelete(type: String)
}
