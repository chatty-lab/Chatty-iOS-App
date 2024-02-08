//
//  EmptyResponseDTO.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/2/24.
//

import Foundation

public struct EmptyResponseDTO: Decodable {
  let code: Int
  let status: String
  let message: String
  
  public init(code: Int, status: String, message: String) {
    self.code = code
    self.status = status
    self.message = message
  }
  
  public func toDomain() -> Void {
    return Void()
  }
}
