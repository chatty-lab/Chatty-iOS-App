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

final class TermsCheckBoxView: UIView, Touchable {
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
  
  private let accesoryView: UIView = UIView()
  private let accesoryImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(systemName: "chevron.right")
    $0.tintColor = UIColor(asset: Colors.gray500)
    $0.contentMode = .scaleAspectFit
  }
  
  private let disposeBag = DisposeBag()
  public let didTouch: PublishRelay<TouchType> = .init()
  
  var terms: Terms {
    didSet {
      checkCircleImageView.currentState = terms.isConsented ? .checked : .unChecked
    }
  }
  
  init(term: Terms) {
    self.terms = term
    super.init(frame: .zero)
    bind()
    setupTermsText()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TermsCheckBoxView {
  enum TouchType {
    case consent(Terms)
    case open(Terms)
  }
  
  private func bind() {
    accesoryView.rx.tapGesture { gesture, delegate in
      delegate.simultaneousRecognitionPolicy = .never
    }.when(.recognized)
      .withUnretained(self)
      .map { _ in .open(self.terms) }
      .bind(to: self.didTouch)
      .disposed(by: disposeBag)
    
    self.rx.tapGesture { gesture, delegate in
      delegate.simultaneousRecognitionPolicy = .never
    }.when(.recognized)
      .withUnretained(self)
      .map { _ in .consent(self.terms) }
      .bind(to: self.didTouch)
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    setupCheckBoxImageView()
    setupTermsLabel()
    setupAccesoryView()
  }
  
  private func setupCheckBoxImageView() {
    addSubview(checkCircleImageView)
    checkCircleImageView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
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
  
  private func setupAccesoryView() {
    addSubview(accesoryView)
    accesoryView.addSubview(accesoryImageView)
    
    accesoryView.snp.makeConstraints {
      $0.trailing.top.bottom.equalToSuperview()
      $0.width.equalTo(30)
    }
    
    accesoryImageView.snp.makeConstraints {
      $0.trailing.centerY.equalToSuperview()
      $0.size.equalTo(16)
    }
  }
}


