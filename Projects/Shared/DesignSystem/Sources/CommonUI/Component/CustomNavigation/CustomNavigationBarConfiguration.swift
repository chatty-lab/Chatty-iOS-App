//
//  CustomNavigationBarConfiguration.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/23/24.
//

import Foundation

public protocol CustomNavigationBarConfigurable: Equatable {
  var identifier: UUID { get }
  var titleView: CustomNavigationBarItem? { get }
  var titleAlignment: CustomNavigationBar.TitleAlignment { get }
  var rightButtons: [CustomNavigationBarButton] { get }
}

public struct CustomNavigationBarConfiguration: CustomNavigationBarConfigurable {
  public typealias Item = CustomNavigationBarItem
  public typealias Button = CustomNavigationBarButton
  public typealias Alignment = CustomNavigationBar.TitleAlignment
  
  public var identifier: UUID = UUID()
  public var titleView: Item?
  public var titleAlignment: Alignment
  public var rightButtons: [Button]
  
  public init(titleView: Item? = nil, titleAlignment: Alignment = .center, rightButtons: [Button] = []) {
    guard rightButtons.count < 5 else {
      fatalError("CustomNavigationBarConfiguration Error: 버튼은 최대 4개까지 등록할 수 있습니다.")
    }
    self.titleView = titleView
    self.titleAlignment = titleAlignment
    self.rightButtons = rightButtons
  }
}
