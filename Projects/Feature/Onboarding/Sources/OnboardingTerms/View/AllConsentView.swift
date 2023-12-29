//
//  AllConsentView.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import SnapKit
import SharedDesignSystem

final class AllConsentView: UIView {
  var configurations: [State : Configuration] = [:]
  var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  private let allConsentLabel: UILabel = UILabel().then {
    $0.text = "전체 동의"
    $0.textColor = UIColor(asset: Colors.basicBlack)
    $0.font = Font.Pretendard(.Regular).of(size: 14)
  }
  
  private let checkBoxImageView: CheckMarkCircleView = CheckMarkCircleView().then {
    typealias Configuration = CheckMarkCircleView.CheckMarkCircleConfiguration
    let uncheckedConfig = Configuration(tintColor: UIColor(asset: Colors.gray500)!)
    let checkedConfig = Configuration(tintColor: UIColor(asset: Colors.primaryNormal)!)
    
    $0.setState(uncheckedConfig, for: .unChecked)
    $0.setState(checkedConfig, for: .checked)
    $0.currentState = .unChecked
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AllConsentView {
  private func configureUI() {
    layer.borderWidth = 0.7
    layer.cornerRadius = 8
    
    setupAllConsentLabel()
    setupCheckBoxImageView()
  }
  
  private func setupAllConsentLabel() {
    addSubview(allConsentLabel)
    allConsentLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(18)
      $0.centerY.equalToSuperview()
    }
  }
  
  private func setupCheckBoxImageView() {
    addSubview(checkBoxImageView)
    checkBoxImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-18)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(22)
    }
  }
}

extension AllConsentView: StateConfigurable {
  enum State {
    case checked
    case unChecked
  }
  
  struct Configuration {
    let tintColor: UIColor
    
    init(tintColor: UIColor) {
      self.tintColor = tintColor
    }
  }
  
  func updateForCurrentState() {
    guard let currentState,
          let config = configurations[currentState] else { return }
    
    self.layer.borderColor = config.tintColor.cgColor
    
    switch currentState {
    case .checked:
      self.checkBoxImageView.currentState = .checked
    case .unChecked:
      self.checkBoxImageView.currentState = .unChecked
    }
  }
}
