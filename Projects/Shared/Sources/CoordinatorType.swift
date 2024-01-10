//
//  CoordinatorType.swift
//  Shared
//
//  Created by walkerhilla on 12/25/23.
//

import UIKit

public enum CoordinatorType {
  case app, tab
  case live, chat, feed, myChatty
  case onboarding(OnboardingType)
}

public enum OnboardingType {
  case root, terms, auth, profileUpdate(OnboardingProfileType)
}

public enum OnboardingProfileType {
  case nickName, profiles
}
