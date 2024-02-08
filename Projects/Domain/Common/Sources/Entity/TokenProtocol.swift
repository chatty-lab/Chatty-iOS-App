//
//  TokenProtocol.swift
//  DomainCommon
//
//  Created by HUNHIE LEE on 2/4/24.
//

import Foundation

public protocol TokenProtocol {
  var accessToken: String { get }
  var refreshToken: String { get }
}
