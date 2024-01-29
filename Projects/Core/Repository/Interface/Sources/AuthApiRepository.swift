//
//  File.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainCommonInterface
import RxSwift

public protocol AuthApiRepositoryProtocol: AuthApiRepository {
  func requestTokenRefresh(refreshToken: String) -> Single<Token>
}
