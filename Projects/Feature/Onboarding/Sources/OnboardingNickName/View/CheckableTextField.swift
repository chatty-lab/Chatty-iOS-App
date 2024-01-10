//
//  CheckableTextField.swift
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
 
public final class ButtomLineTextField2: UIView {
  // MARK: - View Property
  public let textField: UITextField = UITextField().then {
    $0.placeholder = "최대 10자"
    $0.font = SystemFont.title01.font
    $0.textColor = SystemColor.basicBlack.uiColor
//    $0.autocapitalizationType = .none
    $0.backgroundColor = .lightGray
//    $0.addBorder(
//      toSide: .bottom,
//      withColor: SystemColor.gray700.uiColor.cgColor,
//      andThickness: 1
//    )
  }
  
  // MARK: - Rx Property
  let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  let textRelay = BehaviorRelay<String>(value: "")

  // MARK: - init
  public override init(frame: CGRect) {
    super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    bind()
    configureUI()
    textField.delegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ButtomLineTextField2: UITextFieldDelegate {
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    print("textFieldDidBeginEditing - ture")
  }
}

extension ButtomLineTextField2 {
  private func bind() {
    
  }
  private func configureUI() {
    setupNickNameTextField()
  }
  private func setupNickNameTextField() {
    addSubview(textField)
    textField.snp.makeConstraints {
      $0.top.trailing.leading.bottom.equalToSuperview()
    }
  }
}
