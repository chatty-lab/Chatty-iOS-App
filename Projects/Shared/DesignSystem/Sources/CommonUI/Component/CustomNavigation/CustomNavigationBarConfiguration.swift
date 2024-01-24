//
//  CustomNavigationBarConfiguration.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/23/24.
//

import Foundation

protocol CustomNavigationBarConfigurable: Equatable {
  var titleView: CustomNavigationBarItem? { get }
  var titleAlignment: CustomNavigationBar.TitleAlignment { get }
}

public struct CustomNavigationBarConfiguration: CustomNavigationBarConfigurable {
  public typealias Item = CustomNavigationBarItem
  public typealias Button = CustomNavigationBarButton
  public typealias Alignment = CustomNavigationBar.TitleAlignment
  
  public var titleView: Item?
  public var titleAlignment: Alignment
  public var rightButtons: [Button]
  
  public init(titleView: Item? = nil, titleAlignment: Alignment = .center, rightButtons: [Button] = []) {
    self.titleView = titleView
    self.titleAlignment = titleAlignment
    self.rightButtons = rightButtons
  }
}
