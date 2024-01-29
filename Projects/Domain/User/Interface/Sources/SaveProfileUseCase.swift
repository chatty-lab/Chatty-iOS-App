//
//  SaveProfileUseCase.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import DomainCommonInterface
import RxSwift

public protocol SaveProfileUseCase {
  func requestNicknameSave(nickname: String) -> Single<Bool>
  func requestProfileDataSave(
    gender: String,
    birth: String,
    imageData: Data,
    mbti: String
  ) -> Single<Bool>
  func requestProfileData() -> Single<UserData>
}
