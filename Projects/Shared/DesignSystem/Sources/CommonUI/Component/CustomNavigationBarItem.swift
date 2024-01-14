//
//  CustomNavigationBarItem.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/14/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

open class CustomNavigationBarItem: BaseControl, Fadeable {
  // MARK: - View Property
  private lazy var view: UIView? = UIView()
  
  private lazy var imageView: UIImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private lazy var titleLabel: UILabel = UILabel().then {
    $0.font = SystemFont.title02.font
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.textAlignment = .center
    $0.sizeToFit()
  }

  // MARK: - Initialize Method
  init(_ view: UIView? = nil) {
    super.init(frame: .zero)
    self.view = view
    setupView(view)
  }
  
  init(_ image: UIImage? = nil) {
    super.init(frame: .zero)
    self.imageView.image = image
    setupImageView(imageView)
  }
  
  init(_ title: String? = nil) {
    super.init(frame: .zero)
    self.titleLabel.text = title
    setupTitleLabel(titleLabel)
  }
  
  private func setupView(_ view: UIView?) {
    guard let view else { return }
    addSubview(view)
    view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setupImageView(_ view: UIImageView?) {
    guard let view else { return }
    addSubview(view)
    view.snp.makeConstraints {
      $0.centerY.centerX.equalToSuperview()
      $0.size.equalTo(24)
    }
  }
  
  private func setupTitleLabel(_ label: UILabel?) {
    guard let label else { return }
    addSubview(label)
    label.snp.makeConstraints {
      $0.centerY.centerX.equalToSuperview()
    }
  }
}
