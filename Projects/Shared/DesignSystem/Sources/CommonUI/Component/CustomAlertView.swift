//
//  CustomAlertView.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/6/24.
//

import UIKit
import RxSwift
import RxCocoa

final class CustomAlertView: BaseControl, Touchable, Fadeable, Zoomable, Transformable {
  // MARK: - View Property
  private let containerView: UIView = UIView()
  
  private let labelStackView: UIStackView = UIStackView().then {
    $0.spacing = 8
    $0.alignment = .fill
    $0.distribution = .fill
    $0.axis = .vertical
  }
  
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .center
  }
  
  private let messageLabel: UILabel = UILabel().then {
    $0.font = SystemFont.body03.font
    $0.textColor = SystemColor.gray700.uiColor
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.lineBreakMode = .byCharWrapping
  }
  
  private let buttonStackView: UIStackView = UIStackView().then {
    $0.spacing = 4
    $0.alignment = .fill
    $0.distribution = .fillEqually
    $0.axis = .vertical
  }
  
  private let title: String?
  private let message: String?
  
  public init(title: String?, message: String?) {
    self.title = title
    self.message = message
    super.init(frame: .zero)
    setupTitleAndMessageLabel(title, message)
  }
  
  // MARK: - Touchable
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  public override func configureUI() {
    layer.cornerRadius = 12
    backgroundColor = SystemColor.basicWhite.uiColor
    alpha = 0
    
    addSubview(containerView)
    containerView.addSubview(messageLabel)
    
    containerView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(28)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.bottom.equalToSuperview().offset(-20)
    }
  }
  
  private func setupTitleAndMessageLabel(_ title: String?, _ message: String?) {
    containerView.addSubview(labelStackView)
    labelStackView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(6)
    }
    
    guard let title else { return }
    titleLabel.text = title
    labelStackView.addArrangedSubview(titleLabel)
    
    guard let message else { return }
    messageLabel.text = message
    labelStackView.addArrangedSubview(messageLabel)
  }
  
  public func setAction(_ alertAction: CustomAlertAction) {
    guard let style = alertAction.currentState else { return }
    setupButtonStackView()
    switch style {
    case .destructive:
      setupDestructiveButton(alertAction)
    case .cancel:
      setupCancelButton(alertAction)
    }
  }
  
  private func setupButtonStackView() {
    guard !containerView.subviews.contains(buttonStackView) else { return }
    containerView.addSubview(buttonStackView)
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(labelStackView.snp.bottom).offset(32)
      $0.horizontalEdges.equalToSuperview().inset(6)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setupDestructiveButton(_ positiveButton: CustomAlertAction) {
    guard !self.buttonStackView.arrangedSubviews.contains(positiveButton) else { return }
    buttonStackView.addArrangedSubview(positiveButton)
    positiveButton.snp.makeConstraints {
      $0.height.equalTo(46)
    }
    positiveButton.touchEventRelay
      .map { .destructive }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  private func setupCancelButton(_ negativeButton: CustomAlertAction) {
    guard !self.buttonStackView.arrangedSubviews.contains(negativeButton) else { return }
    buttonStackView.addArrangedSubview(negativeButton)
    negativeButton.snp.makeConstraints {
      $0.height.equalTo(46)
    }
    negativeButton.touchEventRelay
      .map { .cancel }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    // CancelButton 추가 시 ContainerView 바닥 여백 조정
    containerView.snp.updateConstraints {
      $0.bottom.equalToSuperview().offset(-12)
    }
  }
}

extension CustomAlertView {
  public enum TouchEventType {
    case destructive
    case cancel
  }
}
