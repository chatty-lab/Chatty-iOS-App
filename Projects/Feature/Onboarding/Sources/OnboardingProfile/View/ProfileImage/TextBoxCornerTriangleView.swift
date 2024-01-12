//
//  TextBoxCornerTriableView.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/12/24.
//

import UIKit

public final class TextBoxCornerTriangleView: UIView {
  init(
    viewColor: UIColor,
    startX: CGFloat = 0,
    width: CGFloat,
    height: CGFloat
  ) {
    super.init(frame: .zero)
    self.backgroundColor = viewColor
    
    let path = CGMutablePath()

    let tipWidthCenter = width / 2.0
    
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: width, y: 0))
    path.addLine(to: CGPoint(x: startX + tipWidthCenter, y: height))
    path.addLine(to: CGPoint(x: startX, y: 0))
    
    let shape = CAShapeLayer()
    shape.path = path
    shape.fillColor = viewColor.cgColor

    self.layer.insertSublayer(shape, at: 0)
    self.layer.masksToBounds = false
    self.layer.cornerRadius = 16
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
