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
}

