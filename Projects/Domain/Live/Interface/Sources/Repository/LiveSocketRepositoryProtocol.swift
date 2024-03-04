//
//  LiveSocketRepositoryProtocol.swift
//  DomainLiveInterface
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import RxSwift

public protocol LiveSocketRepositoryProtocol {
  func connectSocket() -> PublishSubject<MatchSocketResult>
  func sendRequest(_ match: MatchResult)
  func disconnectSocket()
}
