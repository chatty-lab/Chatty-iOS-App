//
//  KeychainCase.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation

public enum KeychainCase {
  case accessToken(_ token: String = "")
  case refreshToken(_ token: String = "")
  case deviceToken(_ token: String = "")
  case deviceId(_ id: String = "")
}
