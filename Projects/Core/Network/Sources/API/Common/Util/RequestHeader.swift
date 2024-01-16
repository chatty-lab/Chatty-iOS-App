//
//  RequestHeader.swift
//  CoreNetwork
//
//  Created by 윤지호 on 1/15/24.
//

import Foundation

public class RequestHeader {
  public func getHeader(_ headers: [HeaderCase]) -> [String: String] {
    var result: [String: String] = [:]
    for header in headers {
      result.merge(header.dict) { _ , new in new }
    }
    return result
  }
}

public enum HeaderCase {
  case accessToken(String)
  case json
  
  var dict: [String: String] {
    switch self {
    case .accessToken(let token):
      return ["Authorization": token]
    case .json:
      return ["Content-Type": "application/json"]
    }
  }
}
