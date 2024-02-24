//
//  AppFlowDelegate.swift
//  Shared
//
//  Created by 윤지호 on 2/24/24.
//

import Foundation

public protocol AppFlowDelegate: AnyObject {
  func showOnboardingFlow()
  func showMainFlow()
}

public final class AppFlowControl {
  public static let shared: AppFlowControl = AppFlowControl()
  public weak var delegete: AppFlowDelegate?
  
  private init() { }
}
