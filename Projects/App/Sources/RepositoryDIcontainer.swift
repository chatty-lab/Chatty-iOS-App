//
//  RepositoryDIcontainer.swift
//  Chatty
//
//  Created by 윤지호 on 2/20/24.
//

import Foundation
import DomainUser
import DomainAuth
import DomainCommon

import DataNetwork
import DataStorage
import DataRepository

public protocol RepositoryDIcontainer {
  func makeUserAPIRepository() -> DefaultUserAPIRepository
  func makeAuthAPIRepository() -> DefaultAuthAPIRepository
  func makeKeychainRepository() -> DefaultKeychainReposotory
  func makeUserDataRepository() -> DefaultUserDataRepository
}

extension RepositoryDIcontainer {
  func makeUserAPIRepository() -> DefaultUserAPIRepository {
    return DefaultUserAPIRepository(
      userAPIService: UserAPIServiceImpl(
        authAPIService: AuthAPIServiceImpl(
          keychainService: KeychainService.shared),
        keychainService: KeychainService.shared
      )
    )
  }
  
  func makeAuthAPIRepository() -> DefaultAuthAPIRepository {
    return DefaultAuthAPIRepository(
      authAPIService: AuthAPIServiceImpl(
        keychainService: KeychainService.shared
      )
    )
  }
  
  func makeKeychainRepository() -> DefaultKeychainReposotory {
    return DefaultKeychainReposotory(
      keychainService: KeychainService.shared
    )
  }
  
  func makeUserDataRepository() -> DefaultUserDataRepository {
    return DefaultUserDataRepository(
      userDataService: UserDataService.shared
    )
  }
}
