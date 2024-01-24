//
//  PaddingLabel.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/12/24.
//

import UIKit

public final class BasePaddingLabel: UILabel {
  private var padding = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
  
  convenience init(padding: UIEdgeInsets) {
    self.init()
    self.padding = padding
  }
   
  public override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: padding))
  }
  
  public override var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += padding.top + padding.bottom
    contentSize.width += padding.left + padding.right
    
    return contentSize
  }
  
  public override var bounds: CGRect {
    didSet {
      preferredMaxLayoutWidth = bounds.width - (padding.left + padding.right)
    }
  }
}

