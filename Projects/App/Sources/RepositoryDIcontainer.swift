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
  func makeChatSTOMPRepository() -> DefaultChatSTOMPRepository
  func makeChatAPIRepository() -> DefaultChatAPIRepository
}

extension RepositoryDIcontainer {
  func makeUserAPIRepository() -> DefaultUserAPIRepository {
    return DefaultUserAPIRepository(
      userAPIService: UserAPIServiceImpl(
        authAPIService: AuthAPIServiceImpl(
          keychainService: KeychainService.shared),
        keychainService: KeychainService.shared
      ),
      profileAPIService: ProfileAPIServiceImpl(
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
  
  func makeChatSTOMPRepository() -> DefaultChatSTOMPRepository {
    return DefaultChatSTOMPRepository(chatSTOMPService: ChatSTOMPServiceImpl.shared)
  }
  
  func makeChatAPIRepository() -> DefaultChatAPIRepository {
    return DefaultChatAPIRepository(
      chatAPIService: ChatAPIServiceImpl(
        authAPIService: AuthAPIServiceImpl(
          keychainService: KeychainService.shared
        ),
        keychainService: KeychainService.shared)
    )
  }
}
