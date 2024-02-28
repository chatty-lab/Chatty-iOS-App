//
//  UserData.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation

public protocol UserDataProtocol {
  var nickname: String { get }
  var mobileNumber: String { get }
  var birth: String { get }
  var gender: String { get }
  var mbti: String { get }
  var address: String? { get }
  var authority: String { get }
  var imageUrl: String? { get }
  var interests: [String]? { get }
  var job: String? { get }
  var introduce: String? { get }
  var school: String? { get }
  var blueCheck: Bool { get }
}
