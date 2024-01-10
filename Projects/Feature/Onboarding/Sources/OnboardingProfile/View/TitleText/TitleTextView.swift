//
//  TitleTextView.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

public final class TitleTextView: UIView {
  
  //MARK: - View
  private let containerView = UIView()
  
  private let titleTextField: UILabel = UILabel().then {
    $0.font = SystemFont.headLine02.font
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .left
    $0.numberOfLines = 2
  }
  private let descriptionTextField: UILabel = UILabel().then {
    $0.font = SystemFont.body03.font
    $0.textColor = SystemColor.gray700.uiColor
    $0.textAlignment = .left
    $0.numberOfLines = 2
  }
  
  //MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: -
  public override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
  
extension TitleTextView {
  private func configureUI() {
    addSubview(containerView)
    containerView.addSubview(titleTextField)
    containerView.addSubview(descriptionTextField)
    
    containerView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    titleTextField.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().inset(20)
      $0.trailing.equalToSuperview().inset(-20)
      $0.height.greaterThanOrEqualTo(29)
    }
    
    descriptionTextField.snp.makeConstraints {
      $0.top.equalTo(titleTextField.snp.bottom).offset(16)
      $0.leading.equalToSuperview().inset(20)
      $0.trailing.equalToSuperview().inset(-20)
      $0.height.greaterThanOrEqualTo(18)
      $0.bottom.equalToSuperview()
    }
  }
  
  public func updateTitleLabels(_ type: ProfileType, nickName: String = "") {
    titleTextField.text = type.getTitleText(nickName)
    descriptionTextField.text = type.description
  }
}
