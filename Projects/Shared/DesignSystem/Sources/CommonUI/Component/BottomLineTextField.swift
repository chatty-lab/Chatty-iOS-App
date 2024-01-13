//
//  BottomLineTextField.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/4/24.
//

import UIKit
import RxSwift
import RxCocoa

open class BottomLineTextField: BaseView, InputReceivable {
  // MARK: - View Property
  public let textField: UITextField = UITextField()
  
  private let bottomLine: BackgroundView = BackgroundView().then {
    typealias Configuration = BackgroundView.Configuration
    let inactiveConfig = Configuration(backgroundColor: SystemColor.gray300.uiColor)
    let activateConfig = Configuration(backgroundColor: SystemColor.primaryNormal.uiColor)
    
    $0.setState(inactiveConfig, for: .inactive)
    $0.setState(activateConfig, for: .activate)
    
    $0.currentState = .inactive
  }
  
  private let resetTextButton: ChangeableImageButton = ChangeableImageButton().then {
    typealias Configuration = ChangeableImageButton.Configuration
    let enabled = Configuration(image: UIImage(systemName: "xmark.circle.fill")!, tintColor: SystemColor.gray300.uiColor, isEnabled: true)
    let disabled = Configuration(image: UIImage(), isEnabled: false)
    
    $0.setState(enabled, for: .enabled)
    $0.setState(disabled, for: .disabled)
    $0.currentState = .disabled
  }
  
  private let maxTextLength: Int
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
    
  // MARK: - InputReceivable
  public let inputEventRelay: PublishRelay<String> = .init()
    
  // MARK: - Initialize Method
  public init(maxTextLength: Int) {
    self.maxTextLength = maxTextLength
    super.init(frame: .zero)
    textField.delegate = self
  }
  
  // MARK: - UIBinable
  open override func bind() {
    resetTextButton.touchEventRelay
      .bind(with: self) { owner, _ in
        owner.textField.text = ""
        owner.inputEventRelay.accept("")
      }
      .disposed(by: disposeBag)
    
    inputEventRelay
      .bind(with: self) { owner, string in
        if string.isEmpty {
          owner.resetTextButton.currentState = .disabled
        } else {
          owner.resetTextButton.currentState = .enabled
        }
      }
      .disposed(by: disposeBag)
  }
  
  
  // MARK: - UIConfigurable
  open override func configureUI() {
    addSubview(textField)
    textField.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    addSubview(bottomLine)
    bottomLine.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom)
      $0.horizontalEdges.equalToSuperview()
      $0.height.equalTo(1.5)
    }
    
    addSubview(resetTextButton)
    resetTextButton.snp.makeConstraints {
      $0.width.equalTo(22)
      $0.size.equalTo(22)
      $0.trailing.equalTo(textField.snp.trailing)
      $0.centerY.equalTo(textField.snp.centerY)
    }
  }
}

extension BottomLineTextField: UITextFieldDelegate {
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    bottomLine.currentState = .activate
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    bottomLine.currentState = .inactive
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let currentText = textField.text, let range = Range(range, in: currentText) else { return true }
    let updatedText = currentText.replacingCharacters(in: range, with: string)
    guard maxTextLength >= updatedText.count else { return false }
    inputEventRelay.accept(updatedText)
    
    return true
  }
}
