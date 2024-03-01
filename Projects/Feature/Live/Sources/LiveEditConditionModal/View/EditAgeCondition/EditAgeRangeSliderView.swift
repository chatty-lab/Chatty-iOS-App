//
//  EditAgeRangeSlider.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import SharedDesignSystem

final class EditAgeRangeSliderView: BaseView {
  // MARK: - View Property
  private let ageRangeStackView: UIStackView = UIStackView()
  
  private let startSlider: UISlider = UISlider()
  
  private let rangeView: UIView = UIView().then {
    $0.backgroundColor = SystemColor.primaryNormal.uiColor
  }
  
  // MARK: - Rx Property
  private let disposeBag = DisposeBag()
  
  // MARK: - Touch Property
  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  // MARK: - UIConfigurable
  override func configureUI() {
    setSlider()
  }
  
  // MARK: - UIBindable
  override func bind() {
    
  }
}

extension EditAgeRangeSliderView {
  enum TouchEventType {
    case startAge(Int)
    case endAge(Int)
  }
}

extension EditAgeRangeSliderView {
  private func setSlider() {
    startSlider.minimumTrackTintColor = .red

    
    startSlider.minimumValue = 1
    startSlider.maximumValue = 5
    startSlider.value = 1
    
    
    addSubview(ageRangeStackView)
    addSubview(startSlider)
    

    ageRangeStackView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.horizontalEdges.equalToSuperview()
      $0.height.equalTo(42)
    }
    
    startSlider.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.horizontalEdges.equalToSuperview()
      $0.height.equalTo(42)
    }
    
    
  }
}

//class StarRatingUISlider: UISlider {
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let width = self.frame.size.width
//        let tapPoint = touch.location(in: self)
//        let fPercent = tapPoint.x/width
//        let nNewValue = self.maximumValue * Float(fPercent)
//        if nNewValue != self.value {
//            self.value = nNewValue
//        }
//        return true
//    }
//}

