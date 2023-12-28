//
//  StateConfigurable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit

public protocol StateConfigurable: UIView {
  associatedtype State: Hashable
  associatedtype Configuration
  
  var configurations: [State: Configuration] { get set }
  var currentState: State? { get set }
  
  func setState(_ config: Configuration, for state: State) -> Void
  func updateForCurrentState()
}

public extension StateConfigurable {
  func setState(_ config: Configuration, for state: State) {
    self.configurations[state] = config
  }
}
