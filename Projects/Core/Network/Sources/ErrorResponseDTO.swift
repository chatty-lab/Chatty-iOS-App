//
//  ErrorResponse.swift
//  CoreNetwork
//
//  Created by 윤지호 on 1/14/24.
//

import Foundation

struct ErrorResponseDTO: Decodable {
  let errorCode: String
  let status: String
  let message: String
}
