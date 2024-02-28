//
//  MatchConditionButton.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/28/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SharedDesignSystem

final class MatchConditionButton: UIControl, Touchable, Highlightable {
  // MARK: - View Property
  private let imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  private let summaryLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title03.font
    $0.textColor = SystemColor.gray600.uiColor
  }
  
  // MARK: - Rx Property
  let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let touchEventRelay = PublishRelay<Void>()
  
  // MARK: - Initialize Method
  required init() {
    super.init(frame: .init())
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MatchConditionButton {
  private func bind() {
    self.rx.controlEvent(.touchDown)
      .bind(with: self) { owner, _ in
        owner.highlight(owner)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
      self.rx.controlEvent(.touchDragExit).map { _ in Void() },
      self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { owner, _ in
      owner.unhighlight(owner)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .map { _ in Void() }
      .withUnretained(self)
      .do { owner, _ in
        self.unhighlight(owner)
      }
      .map { _ in Void() }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    backgroundColor = SystemColor.gray100.uiColor
    setRoundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 16)
    
    addSubview(imageView)
    addSubview(summaryLabel)
    
    imageView.snp.makeConstraints {
      $0.height.leading.equalTo(32)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-16)
    }
    
    summaryLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(10)
      $0.height.equalTo(19)
      $0.centerX.equalToSuperview()
    }
  }
}

extension MatchConditionButton {
  func setLabelText(_ text: String) {
    summaryLabel.text = text
  }
  
  func setImage(_ image: UIImage) {
    imageView.image = image
  }
}
