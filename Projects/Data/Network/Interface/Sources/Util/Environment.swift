//
//  Environment.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 1/16/24.
//

import Foundation

public enum Environment {
  public static var baseURL: String {
    return Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String ?? ""
  }
}
