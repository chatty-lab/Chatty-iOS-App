//
//  TermsCheckBoxView.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
import SharedDesignSystem

final class TermsCheckBoxView: BaseControl, Touchable, TouchableHighlight, TouchableTransform {
  // MARK: - View Property
  private let checkCircleImageView: CheckMarkCircleView = CheckMarkCircleView().then {
    typealias Configuration = CheckMarkCircleView.CheckMarkCircleConfiguration
    let uncheckedConfig = Configuration(tintColor: UIColor(asset: Colors.gray500)!)
    let checkedConfig = Configuration(tintColor: UIColor(asset: Colors.primaryNormal)!)
    
    $0.setState(uncheckedConfig, for: .unChecked)
    $0.setState(checkedConfig, for: .checked)
    $0.currentState = .unChecked
  }
  
  private let termsLabel: UILabel = UILabel().then {
    $0.font = Font.Pretendard(.Regular).of(size: 14)
    $0.textColor = UIColor(asset: Colors.basicBlack)
    $0.textAlignment = .left
    $0.sizeToFit()
  }
  
  private let rightArrowView: UIControl = UIControl()
  
  private let rightArrowImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(systemName: "chevron.right")
    $0.tintColor = UIColor(asset: Colors.gray500)
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: - Stored Property
  var terms: Terms {
    didSet {
      checkCircleImageView.currentState = terms.isConsented ? .checked : .unChecked
    }
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let didTouch: PublishRelay<TouchType> = .init()
  
  // MARK: - Initialize Method
  init(term: Terms) {
    self.terms = term
    super.init(frame: .zero)
    setupTermsText()
  }
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setupCheckCircleImageView()
    setupTermsLabel()
    setupRightArrowView()
  }
  
  // MARK: - Bindable
  override func bind() {
     self.rx.controlEvent(.touchDown)
      .bind(with: self) { [weak self] owner, _ in
        guard let self else { return }
        owner.shrink(checkCircleImageView)
        owner.highlight(checkCircleImageView)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
        self.rx.controlEvent(.touchDragExit).map { _ in Void() },
        self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { [weak self] _, _  in
      guard let self else { return }
      self.expand(checkCircleImageView)
      self.unhighlight(checkCircleImageView)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .compactMap { [weak self] _ -> TouchType? in
        guard let self else { return nil }
        return .consent(self.terms)
      }
      .do { [weak self] _ in
        guard let self else { return }
        self.expand(checkCircleImageView)
        self.unhighlight(checkCircleImageView)
      }
      .bind(to: didTouch)
      .disposed(by: disposeBag)
    
    rightArrowView.rx.controlEvent(.touchUpInside)
      .compactMap { [weak self] _ -> TouchType? in
        guard let self else { return nil }
        return .open(self.terms)
      }
      .bind(to: didTouch)
      .disposed(by: disposeBag)
  }
}

extension TermsCheckBoxView {
  enum TouchType {
    case consent(Terms)
    case open(Terms)
  }
  
  private func setupCheckCircleImageView() {
    addSubview(checkCircleImageView)
    checkCircleImageView.snp.makeConstraints {
      $0.leading.centerY.equalToSuperview()
      $0.size.equalTo(22)
    }
  }
  
  private func setupTermsLabel() {
    addSubview(termsLabel)
    termsLabel.snp.makeConstraints {
      $0.leading.equalTo(checkCircleImageView.snp.trailing).offset(6)
      $0.trailing.centerY.equalToSuperview()
    }
  }
  
  private func setupTermsText() {
    termsLabel.text = terms.phrase
  }
  
  private func setupRightArrowView() {
    addSubview(rightArrowView)
    rightArrowView.addSubview(rightArrowImageView)
    
    rightArrowView.snp.makeConstraints {
      $0.trailing.top.bottom.equalToSuperview()
      $0.width.equalTo(30)
    }
    
    rightArrowImageView.snp.makeConstraints {
      $0.trailing.centerY.equalToSuperview()
      $0.size.equalTo(16)
    }
  }
}


