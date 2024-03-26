//
//  CircularProgressBarView.swift
//  FeatureLive
//
//  Created by 윤지호 on 3/19/24.
//


import UIKit
import SnapKit
import RxSwift
import SharedDesignSystem

final class CircularProgressBarView: UIView {
  
  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()
  private let startPoint = CGFloat(Double.pi * 1.65)
  private let circleLayerEndPoint = CGFloat(Double.pi * 3.35)
  //                               3.14
//  private let startPoint = CGFloat(Double.pi * 1)
//  private let circleLayerEndPoint = CGFloat(Double.pi * 0.1)

  private var endPointValue: Double = 0
  
  let disposeBag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let circularViewDuration: TimeInterval = 2
    progressAnimation(duration: circularViewDuration)
    triggerLayoutSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.endPointValue = 60
    createCircularPath()
  }
  
  func triggerLayoutSubviews() {
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  private func createCircularPath() {
    let center = CGPoint(x: bounds.midX, y: bounds.midY)
    let circularPath = UIBezierPath(arcCenter: center, radius: 80, startAngle: startPoint, endAngle: circleLayerEndPoint, clockwise: true)
   
    circleLayer.path = circularPath.cgPath
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.lineCap = .round
    circleLayer.lineWidth = 2.0
    circleLayer.strokeEnd = 1.0
    circleLayer.strokeColor = SystemColor.gray200.uiColor.cgColor
    layer.addSublayer(circleLayer)
                            // (3.14 * 0.7) + (3.14 * 1.6) * 60
    let endPoint = CGFloat((Double.pi * 0.7) + (Double.pi * 1.6) * (endPointValue / 100))
    let progressPath = UIBezierPath(arcCenter: center, radius: 80, startAngle: startPoint, endAngle: 5, clockwise: true)
    progressLayer.path = progressPath.cgPath
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.lineCap = .round
    progressLayer.lineWidth = 2.0
    progressLayer.strokeEnd = 1.0
    progressLayer.strokeColor = UIColor.blue.cgColor

//    progressLayer.strokeColor = SystemColor.primaryNormal.uiColor.cgColor
    layer.addSublayer(progressLayer)
  }
  
  func progressAnimation(duration: TimeInterval) {
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    circularProgressAnimation.duration = duration
    circularProgressAnimation.toValue = 1.0
    circularProgressAnimation.fillMode = .forwards
    circularProgressAnimation.isRemovedOnCompletion = false
    progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
  }
}

extension CircularProgressBarView {
  func setCirclePercent(percent: Double) {
    print("percent --> \(percent)")
    self.endPointValue = 60
//    self.progressLayer.removeFromSuperlayer()
    
    createCircularPath()
  }
}
