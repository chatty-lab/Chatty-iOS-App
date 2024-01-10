//
//  BackgroundView.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/4/24.
//

import UIKit

open class BackgroundView: BaseView, StateConfigurable {
  public var configurations: [State : Configuration] = [:]
  
  public var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  public func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    backgroundColor = config.backgroundColor
  }
}

public extension BackgroundView {
  enum State {
    case inactive
    case activate
  }
  
  struct Configuration {
    let backgroundColor: UIColor
  }
}

