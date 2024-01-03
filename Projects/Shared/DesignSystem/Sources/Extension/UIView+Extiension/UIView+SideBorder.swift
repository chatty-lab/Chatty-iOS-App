//
//  UIView+Extension.swift
//  SharedDesignSystem
//
//  Created by 윤지호 on 1/3/24.
//

import UIKit

extension UIView {
  public enum ViewSide {
    case left, right, top, bottom
  }
  public func addBorder(toSides sides: [ViewSide], withColor color: CGColor, andThickness thickness: CGFloat) {
    
    let border = CALayer()
    border.backgroundColor = color
    
    for side in sides {
      switch side {
      case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
      case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
      case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
      case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
      }
      
      layer.addSublayer(border)
    }
  }
}
