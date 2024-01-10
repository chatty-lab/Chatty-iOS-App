//
//  TextBoxCornerView.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//

import UIKit
import SnapKit
import Then
import SharedDesignSystem

public final class TextBoxView: UIView {
  private var textBoxContainerView: UIView = UIView().then {
    $0.backgroundColor = .clear
  }
  private var textBoxView: UIView = UIView().then {
    $0.backgroundColor = SystemColor.gray800.uiColor
    $0.layer.cornerRadius = 8
  }
  private var textBoxCornerView: UIView = UIView(frame: .zero)
  private var textBoxLabel: UILabel = UILabel().then {
    $0.font = SystemFont.body01.font
    $0.textColor = SystemColor.basicWhite.uiColor
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func updateProfileImage(_ isPicked: Bool) {
    textBoxLabel.text = isPicked ? "사진은 나중에 변경할 수 있어요" : "내 사진 등록하고 인증받으세요!"
  }
}

extension TextBoxView {
  private func configureUI() {
    addSubview(textBoxContainerView)
    textBoxContainerView.addSubview(textBoxView)
    textBoxContainerView.addSubview(textBoxCornerView)
    textBoxView.addSubview(textBoxLabel)
    
    textBoxContainerView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.centerX.equalToSuperview()
      $0.width.equalTo(204)
      $0.height.equalTo(47)
    }
    
    textBoxView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(41)
    }
    
    textBoxCornerView.snp.makeConstraints {
      $0.top.equalTo(textBoxView.snp.bottom)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(6)
      $0.width.equalTo(12)
    }
    let textBoxCornerView2 = TextBoxCornerTriableView(
      viewColor: SystemColor.gray800.uiColor,
      width: 12,
      height: 6
    )
    textBoxCornerView.addSubview(textBoxCornerView2)
    textBoxCornerView2.snp.makeConstraints {
      $0.top.trailing.leading.bottom.equalToSuperview()
    }
    
    textBoxLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.height.equalToSuperview()
    }
  }
}

public final class TextBoxCornerTriableView: UIView {
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
