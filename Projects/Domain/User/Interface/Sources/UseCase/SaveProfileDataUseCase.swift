//
//  SaveProfileDataUseCase.swift
//  DomainUser
//
//  Created by 윤지호 on 2/19/24.
//

import Foundation
import RxSwift

public protocol SaveProfileDataUseCase {
  func excute(
    gender: String,
    birth: String,
    imageData: Data,
    mbti: String
  ) -> Single<Bool>
}
