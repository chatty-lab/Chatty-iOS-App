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
  // MARK: - View Property
  private let textBoxCornerView: UIView = UIView(frame: .zero)
  private let textBoxCornerView2 = TextBoxCornerTriangleView(
    viewColor: SystemColor.gray800.uiColor,
    width: 12,
    height: 6
  )
  private var textBoxLabel: BasePaddingLabel = BasePaddingLabel().then {
    $0.font = SystemFont.body01.font
    $0.textColor = SystemColor.basicWhite.uiColor
    $0.backgroundColor = SystemColor.gray800.uiColor
    $0.layer.cornerRadius = 8
    $0.clipsToBounds = true
  }
  
  // MARK: - Innitialize Property
  public override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    updateProfileImage(false)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TextBoxView {
  private func configureUI() {
    addSubview(textBoxCornerView)
    addSubview(textBoxLabel)
    textBoxCornerView.addSubview(textBoxCornerView2)

    textBoxCornerView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.height.equalTo(6)
      $0.width.equalTo(12)
      $0.bottom.equalToSuperview()
    }
    
    textBoxCornerView2.snp.makeConstraints {
      $0.top.trailing.leading.bottom.equalToSuperview()
    }
    
    textBoxLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(textBoxCornerView.snp.top)
      $0.height.equalTo(41)
    }
  }
}

extension TextBoxView {
  public func updateProfileImage(_ isPicked: Bool) {
    textBoxLabel.text = isPicked ? "사진은 나중에 변경할 수 있어요" : "내 사진 등록하고 인증받으세요!"
  }
}
