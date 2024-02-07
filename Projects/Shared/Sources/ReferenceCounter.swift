//
//  ChildViewController.swift
//  Shared
//
//  Created by HUNHIE LEE on 2/8/24.
//

import Foundation

public struct ReferenceCounter {
  public var count: Int = 0
  
  public var isReleased: Bool {
    return count < 1
  }
  
  public init() { }
  
  public mutating func increase() {
    count += 1
  }
  
  public mutating func decrease() {
    count -= 1
  }
}
