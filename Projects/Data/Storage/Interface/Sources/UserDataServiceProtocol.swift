//
//  UserDataServiceProtocol.swift
//  DataStorageInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import DomainUserInterface

public protocol UserDataServiceProtocol {
  func getData() -> UserDataProtocol
  func setData(userData: UserDataProtocol)
}
