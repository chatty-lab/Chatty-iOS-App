//
//  ddd.swift
//  DomainLive
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import DomainLiveInterface

import RxSwift

public final class DefaultConnectMatchUseCase: ConnectMatchUseCase {
  
  private let liveAPIRepository: LiveAPIRepositoryProtocol
  private let liveSocketRepository: LiveSocketRepositoryProtocol
  
  public init(liveAPIRepository: LiveAPIRepositoryProtocol, liveSocketRepository: LiveSocketRepositoryProtocol) {
    self.liveAPIRepository = liveAPIRepository
    self.liveSocketRepository = liveSocketRepository
  }
  
  public func getSocketState() -> PublishSubject<Void> {
    return liveSocketRepository.openSocket()
  }
  
  public func getSocket() -> PublishSubject<MatchSocketResult> {
    return liveSocketRepository.connectSocket()
  }
  
  public func sendData(minAge: Int, maxAge: Int, gender: String, scope: Int? = nil, category: String, blueCheck: Bool) -> Single<MatchResult> {
    
    let matchSingle = liveAPIRepository.requestMatchCondition(minAge: minAge, maxAge: maxAge, gender: gender, scope: scope, category: category, blueCheck: blueCheck)
    
    return matchSingle
      .map { matchResponse in
        self.liveSocketRepository.sendRequest(matchResponse)
        return matchResponse
      }
  }
  
  public func disconnectSocket() {
    liveSocketRepository.disconnectSocket()
  }
}
