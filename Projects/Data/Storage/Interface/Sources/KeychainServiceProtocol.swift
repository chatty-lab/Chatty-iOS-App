//
//  KeychainServiceProtocol.swift
//  DataStorageInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import RxSwift

public protocol KeychainServiceProtocol {
  func createSingle(type: KeychainRouter, isForce: Bool) -> Single<Bool>
  func readSingle(type: KeychainRouter) -> Single<String>
  func updateSingle(type: KeychainRouter) -> Single<Bool>
  func deleteSingle(type: KeychainRouter) -> Single<Bool>
  
  func create(type: KeychainRouter, isForce: Bool) -> Bool
  func read(type: KeychainRouter) -> String?
  func update(type: KeychainRouter) -> Bool
  func delete(type: KeychainRouter) -> Bool
}
