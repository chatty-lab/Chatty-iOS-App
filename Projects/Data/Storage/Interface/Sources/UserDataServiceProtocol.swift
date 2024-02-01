//
//  UserDataServiceProtocol.swift
//  CoreStorageInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import DomainCommonInterface

public protocol UserDataServiceProtocol {
  func getData() -> UserData
  func setData(userData: UserData)
}
