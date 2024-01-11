//
//  ProfileImagePickerView.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

public final class ProfileImagePickerView: BaseView {
  //MARK: - View Property
  private var textBoxView: TextBoxView = TextBoxView()
  private var circleImageButton: CircleImageButton = CircleImageButton()
  
  // MARK: Rx Property
  private let disposeBag = DisposeBag()
  public var touchEventRelay: PublishRelay<Void> = .init()
  
  // MARK: - Initialize Method
  public override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("deinit3 - ProfileImagePickerView")
  }
  
  // MARK: - UIConfigurable
  public override func configureUI() {
    setupTextBoxView()
    setupRoundImageView()
    updateProfileImage()
  }
  
  // MARK: - UIBindable
  public override func bind() {
    circleImageButton.touchEventRelay
      .map { _ in Void() }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
}

extension ProfileImagePickerView {
  private func setupTextBoxView() {
    addSubview(textBoxView)
    
    textBoxView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.centerX.equalToSuperview()
      $0.width.equalTo(204)
      $0.height.equalTo(47)
    }
  }
  
  private func setupRoundImageView() {
    addSubview(circleImageButton)
    
    circleImageButton.snp.makeConstraints {
      $0.size.equalTo(160)
      $0.top.equalTo(textBoxView.snp.bottom).offset(12)
      $0.centerX.equalToSuperview()
    }
  }
}

extension ProfileImagePickerView {
  public func updateProfileImage(_ image: UIImage? = nil) {
    textBoxView.updateProfileImage(image != nil)
    circleImageButton.updateImage(image)
  }
}
