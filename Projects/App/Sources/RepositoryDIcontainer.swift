//
//  RepositoryDIcontainer.swift
//  Chatty
//
//  Created by 윤지호 on 2/20/24.
//

import Foundation
import DomainUser
import DomainAuth
import DomainLive
import DomainCommon

import DataNetwork
import DataStorage
import DataRepository

public protocol RepositoryDIcontainer {
  func makeUserAPIRepository() -> DefaultUserAPIRepository
  func makeAuthAPIRepository() -> DefaultAuthAPIRepository
  func makeKeychainRepository() -> DefaultKeychainReposotory
  func makeUserDataRepository() -> DefaultUserDataRepository
  func makeLiveAPIRepository() -> DefaultLiveAPIRepository
  func makeLiveSocketRepository() -> DefaultLiveSocketRepository

}

extension RepositoryDIcontainer {
  func makeUserAPIRepository() -> DefaultUserAPIRepository {
    return DefaultUserAPIRepository(
      userAPIService: UserAPIServiceImpl(
        authAPIService: AuthAPIServiceImpl(
          keychainService: KeychainService.shared),
        keychainService: KeychainService.shared
      ), profileAPIService: ProfileAPIServiceImpl(
        authAPIService: AuthAPIServiceImpl(keychainService: KeychainService.shared), keychainService: KeychainService.shared)
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
  
  func makeLiveAPIRepository() -> DefaultLiveAPIRepository {
    return DefaultLiveAPIRepository(
      liveAPIService: LiveAPIServiceImpl(
        authAPIService: AuthAPIServiceImpl(
          keychainService: KeychainService.shared
        ),
        keychainService: KeychainService.shared
      )
    )
  }
  
  func makeLiveSocketRepository() -> DefaultLiveSocketRepository {
    return DefaultLiveSocketRepository(
      liveWebSocketService: LiveSocketServiceImpl(
        keychainService: KeychainService.shared, 
        authAPIService: AuthAPIServiceImpl(
          keychainService: KeychainService.shared
        )
      )
    )
  }
}
