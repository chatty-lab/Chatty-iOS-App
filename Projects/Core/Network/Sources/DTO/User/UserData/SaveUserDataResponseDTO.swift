//
//  SaveUserDataResponseDTO.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import DomainCommonInterface

public struct SaveUserDataResponseDTO: CommonResponseDTO {
  public let code: Int
  public let status: String
  public let message: String
  public let data: UserDataReponseDTO
  
  public func toDomain() -> UserData {
    return data.toDomain()
  }
}
