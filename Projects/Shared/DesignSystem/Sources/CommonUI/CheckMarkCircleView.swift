//
//  CheckMarkCircleView.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit

public final class CheckMarkCircleView: UIImageView, Bounceable {
  public var configurations: [State: CheckMarkCircleConfiguration] = [:]
  public var currentState: State? {
    didSet {
      updateForCurrentState()
      bounce()
    }
  }
}

extension CheckMarkCircleView: StateConfigurable {
  public enum State {
    case checked
    case unChecked
  }
  
  public struct CheckMarkCircleConfiguration {
    let tintColor: UIColor
    
    public init(tintColor: UIColor) {
      self.tintColor = tintColor
    }
  }
  
  public func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    self.image = UIImage(systemName: "checkmark.circle.fill")
    self.tintColor = config.tintColor
  }
}
