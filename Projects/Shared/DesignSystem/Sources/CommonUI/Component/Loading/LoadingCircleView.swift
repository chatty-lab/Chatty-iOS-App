//
//  LoadingCircleView.swift
//  SharedDesignSystem
//
//  Created by HUNHIE LEE on 2/5/24.
//

import UIKit

class AnimationCircleStrokeSpin {
  func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let beginTime: Double = 0.5
    let strokeStartDuration: Double = 1.2
    let strokeEndDuration: Double = 0.7
    
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.byValue = Float.pi * 2
    rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
    
    let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeEndAnimation.duration = strokeEndDuration
    strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
    strokeEndAnimation.fromValue = 0
    strokeEndAnimation.toValue = 1
    
    let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
    strokeStartAnimation.duration = strokeStartDuration
    strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
    strokeStartAnimation.fromValue = 0
    strokeStartAnimation.toValue = 1
    strokeStartAnimation.beginTime = beginTime
    
    let groupAnimation = CAAnimationGroup()
    groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
    groupAnimation.duration = strokeStartDuration + beginTime
    groupAnimation.repeatCount = .infinity
    groupAnimation.isRemovedOnCompletion = false
    groupAnimation.fillMode = .forwards
    
    let circle = layerWith(size: size, color: color)
    let frame = CGRect(
      x: (layer.bounds.width - size.width) / 2,
      y: (layer.bounds.height - size.height) / 2,
      width: size.width,
      height: size.height
    )
    
    circle.frame = frame
    circle.add(groupAnimation, forKey: "animation")
    layer.addSublayer(circle)
  }
  
  func layerWith(size: CGSize, color: UIColor) -> CALayer {
    let layer: CAShapeLayer = CAShapeLayer()
    var path: UIBezierPath = UIBezierPath()
    let lineWidth: CGFloat = 2
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -(.pi / 2),
                endAngle: .pi + .pi / 2,
                clockwise: true)
    layer.fillColor = nil
    layer.strokeColor = color.cgColor
    layer.lineWidth = 2
    
    layer.backgroundColor = nil
    layer.path = path.cgPath
    layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    
    return layer
  }
}

public final class IndicatorView: BaseView {
  private let circleView = CircleView()
  private(set) public var isAnimating: Bool = false

  public init() {
    super.init(frame: .zero)
    isHidden = true
    addSubview(circleView)
    circleView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(25)
    }
  }
  
  /**
   Start animating.
   */
  public final func startAnimating() {
    guard !isAnimating else {
      return
    }
    isHidden = false
    isAnimating = true
  }
  
  /**
   Stop animating.
   */
  public final func stopAnimating() {
    guard isAnimating else {
      return
    }
    isHidden = true
    isAnimating = false
    circleView.layer.sublayers?.removeAll()
  }
  
}

public class CircleView: BaseView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    layer.speed = 1
  }
  
  public override var intrinsicContentSize: CGSize {
    return CGSize(width: bounds.width, height: bounds.height)
  }
  
  public override var bounds: CGRect {
    didSet {
      if oldValue != bounds {
        setUpAnimation()
      }
    }
  }
  
  private final func setUpAnimation() {
    let animation = AnimationCircleStrokeSpin()
    var animationRect = frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    let minEdge = min(animationRect.width, animationRect.height)
    
    layer.sublayers = nil
    animationRect.size = CGSize(width: minEdge, height: minEdge)
    animation.setUpAnimation(in: layer, size: animationRect.size, color: SystemColor.primaryNormal.uiColor)
  }
}
