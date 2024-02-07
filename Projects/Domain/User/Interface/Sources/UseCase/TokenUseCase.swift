//
//  TokenUseCase.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol TokenUseCaseProtocol {
  func saveToken(accessToken: String, refreshToken: String) -> Single<Bool>
  func requestAccessToken() -> Single<String>
  func requestTokenRefresh() -> Single<String>
  func requestDeviceToken()
  func requestDeviceId()
}
