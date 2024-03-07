//
//  GetInterestsUserCase.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 3/7/24.
//

import Foundation
import RxSwift

public protocol GetAllInterestsUseCase {
  func execute() -> Single<Interests>
}
