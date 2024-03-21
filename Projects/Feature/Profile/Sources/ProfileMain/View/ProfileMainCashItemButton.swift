//
//  ProfileMainCashItemButton.swift
//  FeatureProfileInterface
//
//  Created by 윤지호 on 3/17/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import SharedDesignSystem

public final class ProfileMainCashItemButton: BaseControl, Touchable, Highlightable {
  // MARK: - View Property
  private let titleLabel: UILabel = UILabel().then {
    $0.textColor = SystemColor.basicBlack.uiColor
    $0.font = SystemFont.body03.font
    $0.textAlignment = .center
  }
  
  private var cashItemView: CashItemView?
  
  private let arrowImageView: UIImageView = UIImageView().then {
    $0.image = Images.smallVArrowRight.image.withRenderingMode(.alwaysTemplate)
  }
  
  // MARK: - Touchable Property
  public let touchEventRelay: PublishRelay<Void> = .init()
  
  // MARK: - Initialize Method
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public override func bind() {
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
      .map { _ in Void() }
      .do { [weak self] _ in
        guard let self else { return }
        self.unhighlight(self)
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  public override func configureUI() {
    layer.cornerRadius = 16
    setupTitleLabel()
  }
  
  private func setupTitleLabel() {
    addSubview(titleLabel)
    addSubview(arrowImageView)
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.height.equalTo(17)
      $0.centerY.equalToSuperview()
    }
    
    arrowImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(20)
      $0.height.width.equalTo(18)
      $0.centerY.equalToSuperview()
    }
  }
  
  private func setupCashItemView() {
    let cashItemView = CashItemView()
    cashItemView.backgroundColor = .clear
    
    addSubview(cashItemView)
    cashItemView.snp.makeConstraints {
      $0.height.equalTo(24)
      $0.trailing.equalTo(arrowImageView.snp.leading).offset(8)
      $0.centerY.equalTo(arrowImageView.snp.centerY)
    }
    
    self.cashItemView = cashItemView
  }
}

extension ProfileMainCashItemButton {
  func setTitleLabel(title: String) {
    titleLabel.text = title
    if titleLabel.text == "보유 아이템" {
      backgroundColor = SystemColor.gray100.uiColor
      titleLabel.textColor = SystemColor.gray800.uiColor
      arrowImageView.tintColor = SystemColor.gray800.uiColor
      setupCashItemView()
    } else {
      backgroundColor = SystemColor.primaryNormal.uiColor
      titleLabel.textColor = SystemColor.basicWhite.uiColor
      arrowImageView.tintColor = SystemColor.basicWhite.uiColor
    }
  }
  
  func setCashItemsData(candyCount: Int, ticketCount: Int) {
    self.cashItemView?.candyCount = candyCount
    self.cashItemView?.ticketCount = ticketCount
  }
}
