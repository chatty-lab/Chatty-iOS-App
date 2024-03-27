//
//  ChatSTOMPError.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 3/7/24.
//

import Foundation

public enum ChatSTOMPError: Error {
  case connected
  case disconnected
  case jsonEncodeError
  case jsonDecodeError
  case refreshTokenExpiration
  case accessTokenExpiration
  case unknownedError
}
