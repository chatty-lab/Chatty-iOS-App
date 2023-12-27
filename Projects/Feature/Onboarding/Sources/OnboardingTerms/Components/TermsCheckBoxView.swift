//
//  TermsCheckBoxView.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/27/23.
//

import UIKit
import RxSwift
import RxGesture
import SnapKit
import SharedDesignSystem

final class TermsCheckBoxView: UIView {
  private let checkBoxImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(systemName: "checkmark.circle.fill")
    $0.tintColor = UIColor(asset: Colors.gray300)
    $0.contentMode = .scaleAspectFill
  }
  
  private let termLabel: UILabel = UILabel().then {
    $0.font = Font.Pretendard(.Regular).of(size: 13)
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
  
  var term: Term? {
    didSet {
      configureUI()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    bindGesture()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

struct Term {
  let type: TermType
  let isRequired: Bool
  
  var phrase: String {
    let isRequired = isRequired ? "필수" : "선택"
    return "\(type.rawValue)에 동의해요. (\(isRequired))"
  }
  
  enum TermType: String {
    case termsOfService = "이용약관"
    case privacyPolicy = "개인정보 처리방침"
    case locationDataUsage = "위치정보 수집 및 이용"
  }
}

extension TermsCheckBoxView {
  private func bindGesture() {
    accesoryView.rx.tapGesture { gesture, delegate in
      delegate.simultaneousRecognitionPolicy = .never
    }.when(.recognized)
      .bind(with: self) { owner, gesture in
        print("악세서리 터치 됐어요")
      }
      .disposed(by: disposeBag)
    
    self.rx.tapGesture { gesture, delegate in
      delegate.simultaneousRecognitionPolicy = .never
    }.when(.recognized)
      .bind(with: self) { owner, gesture in
        print("약관 터치 됐어요")
      }
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    setupCheckBoxImageView()
    setupTermLabel()
    setupAccesoryView()
  }
  
  private func setupCheckBoxImageView() {
    addSubview(checkBoxImageView)
    checkBoxImageView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.size.equalTo(19)
    }
  }
  
  private func setupTermLabel() {
    addSubview(termLabel)
    termLabel.snp.makeConstraints {
      $0.leading.equalTo(checkBoxImageView.snp.trailing).offset(8)
      $0.trailing.centerY.equalToSuperview()
    }
    
    if let term {
      termLabel.text = term.phrase
    }
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
  
  private func createAttributedString(for term: Term) -> NSAttributedString? {
    let termText = term.phrase
    let underlineText = term.type.rawValue
    let attributedString = NSMutableAttributedString(string: termText)
    
    if let underlineRange = termText.range(of: underlineText) {
      let nsRange = NSRange(underlineRange, in: termText)
      attributedString.addAttribute(
        .underlineStyle,
        value: NSUnderlineStyle.single.rawValue,
        range: nsRange
      )
    }
    
    return attributedString
  }
}


