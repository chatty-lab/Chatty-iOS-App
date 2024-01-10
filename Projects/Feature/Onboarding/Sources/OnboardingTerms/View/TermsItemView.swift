//
//  TermsItemView.swift
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

final class TermsItemView: BaseControl, Touchable, Highlightable, Transformable {
  // MARK: - View Property
  private let checkCircleImageView: CheckMarkCircleView = CheckMarkCircleView().then {
    typealias Configuration = CheckMarkCircleView.CheckMarkCircleConfiguration
    let uncheckedConfig = Configuration(tintColor: SystemColor.gray500.uiColor)
    let checkedConfig = Configuration(tintColor: SystemColor.primaryNormal.uiColor)
    
    $0.setState(uncheckedConfig, for: .unChecked)
    $0.setState(checkedConfig, for: .checked)
    $0.currentState = .unChecked
  }
  
  private let termsLabel: UILabel = UILabel().then {
    $0.font = Font.Pretendard(.Regular).of(size: 14)
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .left
    $0.sizeToFit()
  }
  
  private let rightArrowView: UIControl = UIControl()
  
  private let rightArrowImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(systemName: "chevron.right")
    $0.tintColor = SystemColor.gray500.uiColor
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: - Stored Property
  var terms: Terms {
    didSet {
      checkCircleImageView.currentState = terms.isAccepted ? .checked : .unChecked
    }
  }
  
  // MARK: - Touchable Property
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
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
      .bind(with: self) { owner, _ in
        owner.shrink(owner.checkCircleImageView, duration: .fast, with: .custom(0.95))
        owner.highlight(owner.checkCircleImageView)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
        self.rx.controlEvent(.touchDragExit).map { _ in Void() },
        self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { owner, _  in
      owner.expand(owner.checkCircleImageView, duration: .fast, with: .identity)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .compactMap { [weak self] _ -> TouchEventType? in
        guard let self else { return nil }
        return .accept(self.terms)
      }
      .do { [weak self] _ in
        guard let self else { return }
        self.expand(checkCircleImageView, duration: .fast, with: .identity)
        self.unhighlight(checkCircleImageView)
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    rightArrowView.rx.controlEvent(.touchUpInside)
      .compactMap { [weak self] _ -> TouchEventType? in
        guard let self else { return nil }
        return .open(self.terms)
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension TermsItemView {
  enum TouchEventType {
    case accept(Terms)
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


