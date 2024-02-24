//
//  DefaultGetProfileDataUseCase.swift
//  DomainUser
//
//  Created by 윤지호 on 2/19/24.
//

import Foundation
import DomainUserInterface
import RxSwift

public final class DefaultGetUserDataUseCase: GetUserDataUseCase {
  
  private let userAPIRepository: any UserAPIRepositoryProtocol
  private let userDataRepository: any UserDataRepositoryProtocol

  public init(userAPIRepository: any UserAPIRepositoryProtocol, userDataRepository: any UserDataRepositoryProtocol) {
    self.userAPIRepository = userAPIRepository
    self.userDataRepository = userDataRepository
  }
  
  /// 서버에서 UserData를 새로 받아와야하는 경우 true
  /// 메모리에 있는 UserData그대로 가져오는 경우 false
  public func execute(hasFetched: Bool) -> Single<UserDataProtocol> {
    if hasFetched {
      return userAPIRepository.getProfile()
        .flatMap { userData in
          self.userDataRepository.saveUserData(userData: userData)
          return .just(self.userDataRepository.getUserData())
        }
    } else {
      return .just(userDataRepository.getUserData())
    }
  }
  
  public func execute() -> UserDataProtocol {
    return userDataRepository.getUserData()
  }
}
