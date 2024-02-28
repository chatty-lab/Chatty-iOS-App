//
//  UITextView+Extension.swift
//  SharedDesignSystem
//
//  Created by HUNHIE LEE on 2/13/24.
//

import UIKit

public extension UITextView{
  /// 텍스트 뷰 내 컨테이너를 세로 중앙 정렬
  func alignTextVerticallyInContainer() {
    var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
    topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
    self.contentInset.top = topCorrect
  }
}
