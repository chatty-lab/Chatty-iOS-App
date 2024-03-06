//
//  MatchResposeDTO.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import DomainLiveInterface

public struct MatchResponseDTO: CommonResponseDTO {
  public var code: Int
  public var status: String
  public var message: String
  public var data: MatchSocketRequestDTO
  
  public func toDomain() -> MatchResult {
    return data.toDomain()
  }
}
