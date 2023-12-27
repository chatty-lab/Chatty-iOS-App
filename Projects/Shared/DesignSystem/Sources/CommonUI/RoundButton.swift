//
//  RoundButton.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import RxSwift
import SnapKit

public protocol RoundButtonDelegate: AnyObject {
  func didTapped()
}

public class RoundButton: UIButton {
  
  let text: String
  var customConfiguration = UIButton.Configuration.filled()
  public weak var delegate: RoundButtonDelegate?
  
  public init(text: String) {
    self.text = text
    super.init(frame: .zero)
    
    configureUI()
    addTarget(self, action: #selector(didTapped), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RoundButton {
  private func configureUI() {
    var titleAttr = AttributedString(stringLiteral: text)
    titleAttr.font = Font.Pretendard(.SemiBold).of(size: 16)
    
    customConfiguration.attributedTitle = titleAttr
    customConfiguration.titleAlignment = .center
    customConfiguration.baseBackgroundColor = UIColor(asset: Colors.gray300)
    customConfiguration.baseForegroundColor = UIColor(asset: Colors.basicWhite)
    
    configuration = customConfiguration
    
    layer.cornerRadius = 6
  }
  
  @objc func didTapped() {
    delegate?.didTapped()
  }
}
