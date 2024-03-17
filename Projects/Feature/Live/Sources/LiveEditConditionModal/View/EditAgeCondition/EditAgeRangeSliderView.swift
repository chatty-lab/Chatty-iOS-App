//
//  EditAgeRangeSlider.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//
//
//import UIKit
//import SnapKit
//import Then
//import RxSwift
//import RxCocoa
//import SharedDesignSystem
//import DoubleSlider
//
//final class EditAgeRangeSliderView: BaseView {
//  // MARK: - View Property
////  private let ageRangeStackView: UIStackView = UIStackView()
////  private let rangeView: UIView = UIView().then {
////    $0.backgroundColor = SystemColor.primaryNormal.uiColor
////  }
//  
//  private var startSlider: DoubleSlider = DoubleSlider(frame: .init(x: 0, y: 0, width: 200, height: 50))
//  private var labels: [String] = []
//  
//  // MARK: - Rx Property
//  private let disposeBag = DisposeBag()
//  
//  // MARK: - Touch Property
//  public let touchEventRelay: PublishRelay<TouchEventType> = .init()
//  
//  // MARK: - UIConfigurable
//  override func configureUI() {
//    setSlider()
//  }
//  
//  // MARK: - UIBindable
//  override func bind() {
//    
//  }
//  
//}
//
//extension EditAgeRangeSliderView {
//  enum TouchEventType {
//    case startAge(Int)
//    case endAge(Int)
//  }
//}
//
//extension EditAgeRangeSliderView {
//  private func setSlider() {
//
//    for num in stride(from: 0, to: 200, by: 10) {
//      labels.append("$\(num)")
//    }
//    labels.append("No limit")
//    
//    
//    startSlider.labelDelegate = self
//
//    startSlider.valueChangedDelegate = self
//    startSlider.editingDidEndDelegate = self
//    
//    startSlider.numberOfSteps = labels.count
//    startSlider.smoothStepping = true
//
//    startSlider.labelsAreHidden = false
//    
//    startSlider.lowerLabelMarginOffset = 8.0
//    startSlider.upperLabelMarginOffset = 8.0
//
//    startSlider.lowerValueStepIndex = 0
//    startSlider.upperValueStepIndex = labels.count - 1
//    
////    startSlider.trackTintColor = SystemColor.gray400.uiColor
////    startSlider.trackHighlightTintColor = SystemColor.primaryNormal.uiColor
//    
//    addSubview(startSlider)
//    startSlider.snp.makeConstraints {
//      $0.top.equalToSuperview()
//      $0.height.equalTo(50)
//      $0.leading.trailing.equalToSuperview()
//    }
//    
//  }
//}
//
//extension EditAgeRangeSliderView: DoubleSliderValueChangedDelegate {
//  func valueChanged(for doubleSlider: DoubleSlider) {
//    print("doubleSlider1 - \(doubleSlider.lowerValue)")
//    print("doubleSlider2 - \(doubleSlider.upperValue)")
//
//  }
//}
//
//extension EditAgeRangeSliderView: DoubleSliderLabelDelegate {
//  func labelForStep(at index: Int) -> String? {
//    print("labelForStep - \(index)")
//    return "label"
//  }
//  
//  
//}
//
//extension EditAgeRangeSliderView: DoubleSliderEditingDidEndDelegate {
//  func editingDidEnd(for doubleSlider: DoubleSlider) {
//    print("editingDidEnd")
//  }
//  
//  
//}
