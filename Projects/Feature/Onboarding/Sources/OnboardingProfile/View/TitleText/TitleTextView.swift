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
  private let titleTextField: UILabel = UILabel().then {
    $0.font = SystemFont.headLine02.font
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .left
    $0.numberOfLines = 0
  }
  private let descriptionTextField: UILabel = UILabel().then {
    $0.font = SystemFont.body03.font
    $0.textColor = SystemColor.gray700.uiColor
    $0.textAlignment = .left
    $0.numberOfLines = 0
  }
  
  //MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Initialize Method
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
    addSubview(titleTextField)
    addSubview(descriptionTextField)
    
    titleTextField.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.greaterThanOrEqualTo(31)
    }
    
    descriptionTextField.snp.makeConstraints {
      $0.top.equalTo(titleTextField.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.greaterThanOrEqualTo(22)
      $0.bottom.equalToSuperview()
    }
  }
  
  public func updateTitleLabels(_ type: EditProfileType, nickName: String = "") {
    if type != .none {
      titleTextField.text = type.getTitleText(nickName)
      descriptionTextField.text = type.description
    } else {
      titleTextField.text = "닉네임을 만들어 주세요"
      descriptionTextField.text = "상대방에게 보여지는 이름이에요.\n나중에 변경할 수 있어요."
    }
    
  }
}
