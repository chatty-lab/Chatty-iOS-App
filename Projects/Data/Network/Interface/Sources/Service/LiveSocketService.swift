//
//  LiveSocketService.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import RxSwift
import DomainLiveInterface

public protocol LiveSocketService {
  func openSocket() -> PublishSubject<Void>
  func connectSocket() -> PublishSubject<MatchSocketResult>
  func sendRequest(reqeust: MatchSocketRequestDTO)
  func disconnectSocket()
}
