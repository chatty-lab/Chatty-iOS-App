//
//  SaveProfileUseCase.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol SaveProfileNicknameUseCase {
  func excute(nickname: String) -> Single<Bool>
}
