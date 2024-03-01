//
//  CancelButton.swift
//  SharedDesignSystem
//
//  Created by 윤지호 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
import Then

public final class CancelButton: UIControl, Touchable, Highlightable {
  // MARK: - View Property
  private let imageView: UIImageView = UIImageView().then {
    $0.image = Images.close.image
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public let touchEventRelay: PublishRelay<Void> = .init()
  
  // MARK: - Initialize Method
  public override init(frame: CGRect) {
    super.init(frame: frame)
    bind()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CancelButton {
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
    addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.height.width.centerX.centerY.equalToSuperview()
    }
  }
}
