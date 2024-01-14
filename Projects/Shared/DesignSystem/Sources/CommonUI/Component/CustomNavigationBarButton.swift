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

open class CustomNavigationBarButton: CustomNavigationBarItem, Touchable, Highlightable {
  // MARK: - Reactor Property
  public var touchEventRelay: RxRelay.PublishRelay<Void> = .init()
  
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
    
    self.rx.controlEvent(.touchUpInside)
      .map { () }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}
