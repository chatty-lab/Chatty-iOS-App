//
//  CustomNavigationBarItem.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/23/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

open class CustomNavigationBarItem: BaseControl, Touchable {
  // MARK: - View Property
  private let titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title02.font
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .center
  }
  
  private let imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  public var title: String? = nil
  
  // MARK: - Touchable
  public var touchEventRelay: PublishRelay<Void> = .init()
  
  // MARK: - Initialize Method
  public init(title: String) {
    self.title = title
    super.init(frame: .zero)
    setup(title)
  }
  
  public init(image: UIImage) {
    super.init(frame: .zero)
    setup(image)
  }
  
  public init(view: UIView) {
    super.init(frame: .zero)
    setup(view)
  }
  
  // MARK: - UIBindable
  open override func bind() {
    self.rx.controlEvent(.touchUpInside)
      .map { () }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  private func setup(_ title: String) {
    titleLabel.text = title
    titleLabel.sizeToFit()
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setup(_ image: UIImage) {
    imageView.image = image
    addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setup(_ view: UIView) {
    addSubview(view)
    view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
