//
//  MainTabBarItemType.swift
//  Feature
//
//  Created by walkerhilla on 12/26/23.
//

import Foundation
import SharedDesignSystem

enum MainTabBarItemType: Int, CaseIterable {
  case live
  case chat
  case feed
  case myChatty
  
  var tabIconDefault: SharedDesignSystemImages {
    switch self {
    case .live:
      return Images.compassDefault
    case .chat:
      return Images.groupBubbleChatDefault
    case .feed:
      return Images.shareDefault
    case .myChatty:
      return Images.mypageDefault
    }
  }
  
  var tabIconSelected: SharedDesignSystemImages {
    switch self {
    case .live:
      return Images.compassActivated
    case .chat:
      return Images.groupBubbleChatActivated
    case .feed:
      return Images.shareActivated
    case .myChatty:
      return Images.mypageActivated
    }
  }
  
  var title: String {
    switch self {
    case .live:
      return "실시간"
    case .chat:
      return "채팅"
    case .feed:
      return "피드"
    case .myChatty:
      return "나의 채티"
    }
  }
}
