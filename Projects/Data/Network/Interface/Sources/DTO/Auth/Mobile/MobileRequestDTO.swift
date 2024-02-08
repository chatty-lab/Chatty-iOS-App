//
//  MobileRequestDTO.swift
//  DataNetworkInterface
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation

public struct MobileRequestDTO: Encodable {
  let mobileNumber: String
  let deviceId: String
  
  public init(mobileNumber: String, deviceId: String) {
    self.mobileNumber = mobileNumber
    self.deviceId = deviceId
  }
}

