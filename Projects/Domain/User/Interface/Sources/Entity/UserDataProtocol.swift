//
//  UserData.swift
//  DomainCommonInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation

public protocol UserDataProtocol {
  var nickname: String? { get set }
  var mobileNumber: String { get set }
  var birth: String? { get set }
  var gender: String? { get set }
  var mbti: String? { get set }
  var address: String? { get set }
  var authority: String { get set }
  var imageUrl: String? { get set }
  var interests: [Interest] { get set }
  var job: String? { get set }
  var introduce: String? { get set }
  var school: String? { get set }
  var blueCheck: Bool { get set }
}
