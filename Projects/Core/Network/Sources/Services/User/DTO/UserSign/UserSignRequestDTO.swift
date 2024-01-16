//
//  UserSignRequestDTO.swift
//  CoreNetworkInterface
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation

public struct UserSignRequestDTO: Encodable {
  let mobileNumber: String
  let deviceId: String
  let authenticationNumber: String
  let deviceToken: String
}
