//
//  Terms.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/28/23.
//

import Foundation

struct Terms: Hashable {
  let type: TermsType
  let isRequired: Bool
  var isAccepted: Bool = false
  
  var phrase: String {
    let isRequired = isRequired ? "필수" : "선택"
    return "\(type.rawValue)에 동의해요. (\(isRequired))"
  }
  
  enum TermsType: String {
    case termsOfService = "이용약관"
    case privacyPolicy = "개인정보 처리방침"
    case locationDataUsage = "위치정보 수집 및 이용"
  }
}
