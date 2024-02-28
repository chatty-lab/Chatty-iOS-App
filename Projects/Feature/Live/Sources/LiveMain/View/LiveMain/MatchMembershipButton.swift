//
//  MatchMembershipButton.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SharedDesignSystem

final class MatchMembershipButton: UIControl, Touchable, Highlightable {
  // MARK: - View Property
  private let imageView: UIImageView = UIImageView().then {
    $0.image = Images.king.image
    $0.contentMode = .scaleAspectFit
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

extension MatchMembershipButton {
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
    backgroundColor = .white
    layer.cornerRadius = 36 / 2 - 1
    addShadow(offset: CGSize())
    
    addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.size.equalTo(24)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
  }
}
