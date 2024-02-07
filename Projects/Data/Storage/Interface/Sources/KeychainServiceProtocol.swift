//
//  KeychainServiceProtocol.swift
//  DataStorageInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import RxSwift

public protocol KeychainServiceProtocol {
  func create(type: KeychainRouter, isForce: Bool) -> Single<Bool>
  func read(type: KeychainRouter) -> Single<String>
  func update(type: KeychainRouter) -> Single<Bool>
  func delete(type: KeychainRouter) -> Single<Bool>
}
