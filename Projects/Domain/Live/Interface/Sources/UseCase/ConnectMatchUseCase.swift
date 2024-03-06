//
//  ConnectMatchUseCase.swift
//  DomainLiveInterface
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import RxSwift

public protocol ConnectMatchUseCase {
  func sendData(
    minAge: Int,
    maxAge: Int,
    gender: String,
    scope: Int?,
    category: String,
    blueCheck: Bool
  ) -> Single<MatchResult>
  func getSocketState() -> PublishSubject<Void>
  func getSocket() -> PublishSubject<MatchSocketResult>
  func disconnectSocket()
}


