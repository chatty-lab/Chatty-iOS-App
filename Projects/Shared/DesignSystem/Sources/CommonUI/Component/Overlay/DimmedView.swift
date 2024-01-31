//
//  DimmedView.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/7/24.
//

import UIKit

public class DimmedView: BaseView, Fadeable {
  public override func configureUI() {
    backgroundColor = .black
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    alpha = 0
  }
}
