//
//  DefaultGetInterestsUserCase.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 3/7/24.
//

import Foundation
import DomainUserInterface

import RxSwift

public final class DefaultGetInterestsUseCase: GetInterestsUseCase {
  private let userAPIRepository: any UserAPIRepositoryProtocol

  public init(userAPIRepository: any UserAPIRepositoryProtocol) {
    self.userAPIRepository = userAPIRepository
  }
  
  public func execute() -> Single<Interests> {
    return userAPIRepository.getInterests()
  }
}
