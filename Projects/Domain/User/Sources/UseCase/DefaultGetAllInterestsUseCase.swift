//
//  DefaultGetInterestsUserCase.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 3/7/24.
//

import Foundation
import DomainUserInterface

import RxSwift

public final class DefaultGetAllInterestsUseCase: GetAllInterestsUseCase {
  private let userAPIRepository: any UserAPIRepositoryProtocol
  private let userDataRepository: any UserDataRepositoryProtocol
  
  public init(userAPIRepository: any UserAPIRepositoryProtocol, userDataRepository: any UserDataRepositoryProtocol) {
    self.userAPIRepository = userAPIRepository
    self.userDataRepository = userDataRepository
  }
  
  public func execute() -> Single<Interests> {
    return userAPIRepository.getInterests()
      .map { interests in
        self.userDataRepository.saveAllInterests(interests: interests)
        return interests
      }
  }
}
