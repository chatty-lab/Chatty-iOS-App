//
//  UserAuthRequestDTO.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation

public struct UserSignRequestDTO: Encodable {
  let mobileNumber: String
  let authenticationNumber: String
  let deviceId: String
  let deviceToken: String
}
