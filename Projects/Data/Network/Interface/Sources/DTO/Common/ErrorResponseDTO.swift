//
//  ErrorResponse.swift
//  CoreNetwork
//
//  Created by 윤지호 on 1/14/24.
//

import Foundation

public struct ErrorResponseDTO: Decodable, Error {
  let errorCode: String
  let status: String
  let message: String
  
  public func toMappedError() -> NetworkError {
    if let existableErrorCase = ErrorCode(rawValue: errorCode) {
      let errorCase = existableErrorCase.toCase()
      return NetworkError(errorCase: errorCase, massage: errorCase.message)
    } else {
      return NetworkError(errorCase: .UnknownError, massage: message)
    }
  }
}
