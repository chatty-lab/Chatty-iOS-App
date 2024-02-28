//
//  LiveMainControllerDelegate.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import Foundation

protocol LiveMainControllerDelegate: AnyObject {
  func pushToMatchingView()
  func pushToCandyStore()
  func pushToMembershipView()
  func presentEditGenderConditionModal()
  func presentEditAgeConditionModal()
}
