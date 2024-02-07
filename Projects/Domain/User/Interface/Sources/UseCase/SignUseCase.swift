//
//  SignUseCase.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol SignUseCase {
  func requestLogin(mobileNumber: String, authenticationNumber: String) -> Single<Bool>
  func requestJoin(mobileNumber: String, authenticationNumber: String) -> Single<Bool>
}
