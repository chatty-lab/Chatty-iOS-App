//
//  CustomAlertView.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/6/24.
//

import UIKit
import RxSwift
import RxCocoa

public final class CustomAlertView: BaseControl, Touchable, Fadeable, Zoomable, Transformable {
  // MARK: - View Property
  private let titleContainerView: UIView = UIView()
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .center
  }
  
  private let subTitleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.body03.font
    $0.textColor = SystemColor.gray700.uiColor
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.lineBreakMode = .byCharWrapping
  }
  
  private let buttonStackView: UIStackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.spacing = 4
    $0.distribution = .fillEqually
  }
  
  private let positiveButton: CustomAlertButton = CustomAlertButton().then {
    typealias Configuration = CustomAlertButton.Configuration
    let positiveConfig = Configuration(backgroundColor: SystemColor.primaryNormal.uiColor, textColor:  SystemColor.basicWhite.uiColor)

    $0.title = "전송"
    $0.setState(positiveConfig, for: .positive)
    $0.currentState = .positive
  }
  
  private let negativeButton: CustomAlertButton = CustomAlertButton().then {
    typealias Configuration = CustomAlertButton.Configuration
    let negativeConfig = Configuration(backgroundColor: SystemColor.basicWhite.uiColor, textColor: SystemColor.basicBlack.uiColor)
    
    $0.title = "취소"
    $0.setState(negativeConfig, for: .negative)
    $0.currentState = .negative
  }
  
  public var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  public var subTitle: String? {
    didSet {
      subTitleLabel.text = subTitle
    }
  }
  
  // MARK: - Touchable
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  public override func configureUI() {
    layer.cornerRadius = 12
    backgroundColor = SystemColor.basicWhite.uiColor
    alpha = 0
    
    addSubview(titleContainerView)
    titleContainerView.addSubview(titleLabel)
    titleContainerView.addSubview(subTitleLabel)
    titleContainerView.addSubview(buttonStackView)
    
    titleContainerView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(28)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().offset(-20)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(6)
    }
    
    subTitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview().inset(6)
    }
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(subTitleLabel.snp.bottom).offset(32)
      $0.bottom.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(6)
    }
    
    positiveButton.snp.makeConstraints {
      $0.height.equalTo(46)
    }
    
    negativeButton.snp.makeConstraints {
      $0.height.equalTo(46)
    }
  }
  
  public func addButton(_ title: String, for action: Action) {
    switch action {
    case .positive:
      positiveButton.title = title
      buttonStackView.addArrangedSubview(positiveButton)
    case .negative:
      negativeButton.title = title
      buttonStackView.addArrangedSubview(negativeButton)
    }
  }
  
  public override func bind() {
    negativeButton.touchEventRelay
      .map { .negative }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    positiveButton.touchEventRelay
      .map { .positive }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension CustomAlertView {
  public enum TouchEventType {
    case positive
    case negative
  }
  
  public enum Action {
    case positive
    case negative
  }
}
