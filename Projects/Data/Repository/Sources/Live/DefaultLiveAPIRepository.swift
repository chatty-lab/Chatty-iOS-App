//
//  Live.swift
//  DataRepositoryInterface
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import DataNetworkInterface
import DataRepositoryInterface
import DomainLiveInterface

import RxSwift

public final class DefaultLiveAPIRepository: LiveAPIRepository {
  private let liveAPIService: any LiveAPIService
  
  public init(liveAPIService: any LiveAPIService) {
    self.liveAPIService = liveAPIService
  }
  
  public func requestMatchCondition(minAge: Int, maxAge: Int, gender: String, scope: Int?, category: String, blueCheck: Bool) -> Single<MatchResult> {
    let request = MatchRequestDTO(
      minAge: minAge,
      maxAge: maxAge,
      gender: gender,
      scope: scope,
      category: category,
      blueCheck: blueCheck
    )
    
    return liveAPIService.request(endPoint: .match(request: request), responseDTO: MatchResponseDTO.self)
      .map { $0.toDomain() }
  }
}
