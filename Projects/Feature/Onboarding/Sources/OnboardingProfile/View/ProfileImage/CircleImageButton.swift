//
//  CircleImageButton.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
import Then
import SharedDesignSystem

public final class CircleImageButton: UIControl, Touchable, Highlightable {
  // MARK: - View Property
  private var imageView: UIImageView = UIImageView()
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touchable Property
  public var touchEventRelay: RxRelay.PublishRelay<Void> = .init()
  
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

extension CircleImageButton {
  private func bind() {
    self.rx.controlEvent(.touchDown)
      .bind(with: self) { owner, _ in
        print("touch1")
        owner.highlight(owner)
      }
      .disposed(by: disposeBag)
    
    Observable.merge(
      self.rx.controlEvent(.touchDragExit).map { _ in Void() },
      self.rx.controlEvent(.touchCancel).map { _ in Void() }
    )
    .bind(with: self) { owner, _ in
      print("touch2")
      owner.unhighlight(owner)
    }
    .disposed(by: disposeBag)
    
    self.rx.controlEvent(.touchUpInside)
      .map { _ in Void() }
      .withUnretained(self)
      .do { owner, _ in
        self.unhighlight(owner)
      }
      .map { _ in
        print("touch3")
        return Void() }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    self.layer.cornerRadius = 160 / 2
    self.clipsToBounds = true
    self.backgroundColor = SystemColor.gray100.uiColor
    self.layer.borderWidth = 1
    self.layer.borderColor = SystemColor.gray300.uiColor.cgColor
    
    setupImageViews()
  }
  
  private func setupImageViews() {
    addSubview(imageView)
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension CircleImageButton {
  public func updateImage(_ image: UIImage?) {
    if image != nil {
      imageView.image = image
    } else {
     
      let config = UIImage.SymbolConfiguration(pointSize: 26.67)
      let plusImage = UIImage(systemName: "plus", withConfiguration: config)

      imageView.image = plusImage
      imageView.contentMode = .center
      imageView.tintColor = SystemColor.gray600.uiColor
    }
  }
}
