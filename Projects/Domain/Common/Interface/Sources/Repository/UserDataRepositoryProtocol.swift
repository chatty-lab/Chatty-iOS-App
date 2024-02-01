//
//  UserDataRepositoryProtocol.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol UserDataRepositoryProtocol {
  func saveUserData(userData: UserData)
  func getUserData() -> Single<UserData>
}
