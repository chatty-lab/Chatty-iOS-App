//
//  KeychainReposotoryProtocol.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol KeychainReposotoryProtocol {
  func requestCreat(type: KeychainCase) -> Single<Bool>
  func requestRead(type: KeychainCase) -> Single<String>
  func requestDelete(type: KeychainCase) -> Single<Bool>
}
