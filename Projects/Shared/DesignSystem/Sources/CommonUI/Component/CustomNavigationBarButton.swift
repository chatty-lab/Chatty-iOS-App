//
//  CustomNavigationBarButton.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/3/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

open class CustomNavigationBarButton<TouchEventType>: BaseControl, Touchable, Highlightable {
  // MARK: - View Property
  private var imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: - Touchable
  public var touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - Initialize Method
  public convenience init(image: UIImage) {
    self.init(frame: .zero)
    setupImageView(image)
  }
  
  // MARK: - UIConfigurable
  open override func configureUI() {
    addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.leading.trailing.top.bottom.equalToSuperview()
    }
  }
  
  private func setupImageView(_ image: UIImage) {
    self.imageView.image = image
  }
  
  // MARK: - UIBindable
  open override func bind() {
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
  }
}
