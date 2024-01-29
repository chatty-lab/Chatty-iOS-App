//
//  File.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainCommonInterface
import RxSwift

public protocol UserDataRepositoryProtocol: UserDataRepository {
  func saveUserData(userData: UserData)
  func getUserData() -> Single<UserData>
}
