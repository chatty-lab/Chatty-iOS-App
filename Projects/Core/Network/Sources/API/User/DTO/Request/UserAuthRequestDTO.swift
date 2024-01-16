//
//  UserAuthRequestDTO.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation

public struct UserAuthRequestDTO: Encodable {
  let mobileNumber: String
  let authenticationNumber: String
  let deviceId: String
  let deviceToken: String
}
