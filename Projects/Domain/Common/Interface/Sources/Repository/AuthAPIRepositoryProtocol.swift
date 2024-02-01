//
//  AuthAPIRepositoryProtocol.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift

public protocol AuthAPIRepositoryProtocol {
  func requestTokenRefresh(refreshToken: String) -> Single<Token>
}
