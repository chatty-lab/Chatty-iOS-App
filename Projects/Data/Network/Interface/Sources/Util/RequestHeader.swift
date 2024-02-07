//
//  RequestHeader.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation

public enum RequestHeader {
  case accessToken
  case json
  case binary
  
  var dict: [String: String] {
    switch self {
    case .accessToken:
      let accesstoken = "accesstoken"
      return ["Authorization": accesstoken]
    case .json:
      return ["Content-Type": "application/json"]
    case .binary:
      return ["Content-Type": "multipart/form-data"]
    }
  }
  
  public static func getHeader(_ headers: [RequestHeader]) -> [String: String] {
    var result: [String: String] = [:]
    for header in headers {
      result.merge(header.dict) { _ , new in new }
    }
    return result
  }
}
