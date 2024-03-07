//
//  UserDataRepositoryProtocol.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol UserDataRepositoryProtocol {
  func saveUserData(userData: UserDataProtocol)
  func getUserData() -> UserDataProtocol
  func saveAllInterests(interests: Interests)
}
