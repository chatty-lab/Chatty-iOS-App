//
//  AcceptAllButton.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/29/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SharedDesignSystem

final class AcceptAllButton: BaseControl, Touchable, TouchableHighlight {
  // MARK: - View Property
  private let acceptAllLabel: UILabel = UILabel().then {
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
  
  // MARK: - Rx Property
  let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  let didTouch: PublishRelay<Void> = .init()
  
  // MARK: - StateConfigurable Property
  var configurations: [State : Configuration] = [:]
  var currentState: State? {
    didSet {
      updateForCurrentState()
    }
  }
  
  // MARK: - Initialize Method
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func bind() {
    self.rx.controlEvent(.touchDown)
      .bind(with: self) { [weak self] owner, _ in
        guard let self else { return }
        owner.highlight(self)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
        self.rx.controlEvent(.touchDragExit).map { _ in Void() },
        self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { [weak self] _, _  in
      guard let self else { return }
      self.unhighlight(self)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .map { _ in Void() }
      .do { [weak self] _ in
        guard let self else { return }
        self.unhighlight(self)
      }
      .bind(to: didTouch)
      .disposed(by: disposeBag)
  }
  
  override func configureUI() {
    layer.borderWidth = 1
    layer.cornerRadius = 8
    
    setupAcceptAllLabel()
    setupCheckBoxImageView()
  }
}

extension AcceptAllButton {
  private func setupAcceptAllLabel() {
    addSubview(acceptAllLabel)
    acceptAllLabel.snp.makeConstraints {
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

extension AcceptAllButton: StateConfigurable {
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
