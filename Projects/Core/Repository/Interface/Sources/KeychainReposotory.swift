//
//  File.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainCommonInterface
import RxSwift

public protocol KeychainReposotoryProtocol: KeychainReposotory {
  func requestCreat(type: KeychainCase) -> Single<Bool>
  func requestRead(type: KeychainCase) -> Single<String>
  func requestDelete(type: KeychainCase) -> Single<Bool>
}
