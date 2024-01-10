//
//  CertifiedGuideView.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

public final class CertifiedGuideView: UIView {
  // MARK: - View Property
  private let containerView: UIView = UIView().then {
    $0.backgroundColor = SystemColor.gray100.uiColor
    $0.layer.cornerRadius = 8
  }
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.body01.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  private let firstImageView: UIImageView = UIImageView().then {
    $0.backgroundColor = SystemColor.gray300.uiColor
    $0.layer.cornerRadius = 8
  }
  private let secondImageView: UIImageView = UIImageView().then {
    $0.backgroundColor = SystemColor.gray300.uiColor
    $0.layer.cornerRadius = 8
  }
  
  // MARK: - Initialize Method
  public override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CertifiedGuideView {
  private func configureUI() {
    addSubview(containerView)
    containerView.addSubview(titleLabel)
    containerView.addSubview(firstImageView)
    containerView.addSubview(secondImageView)
    
    let viewWidth = UIViewController.viewFrame.width
    let containerWidth = viewWidth - 40
    let containerHeight = (containerWidth * 213) / 335
    print("jeight - \(containerHeight)")
    containerView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.width.equalTo(containerWidth)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.centerX.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16)
      $0.height.equalTo(17)
      $0.centerX.equalToSuperview()
    }
    
    let imageViewHeight = (containerHeight * 150) / 213
    print(imageViewHeight)
    
    firstImageView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(14)
      $0.height.width.equalTo(imageViewHeight)
      $0.leading.equalToSuperview().inset(12)
    }
    
    secondImageView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(14)
      $0.height.width.equalTo(imageViewHeight)
      $0.trailing.equalToSuperview().inset(12)
    }
  }
}

extension CertifiedGuideView {
  public func updateViewProperty(_ isCerified: Bool) {
    titleLabel.text = isCerified ? "얼굴이 잘 보이는 사진으로 올려주세요." : "얼굴이 잘 보이지 않으면 미인증 가입돼요."
    let color: UIColor = isCerified ? .blue : .red

//    firstImageView.image = UIImage(named: "cerity-\(isCerified)")
//    secondImageView.image = UIImage(named: "cerity-\(isCerified)")
  }
}
