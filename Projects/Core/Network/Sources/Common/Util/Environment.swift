//
//  Environment.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation

public enum Environment {
  static var baseURL: String {
    return Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String ?? ""
  }
}