//
//  UserData.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation

public protocol UserDataProtocol {
  var nickname: String { get }
  var mobileNumber: String { get }
  var birth: String { get }
  var gender: Gender { get }
  var mbti: String { get }
  var address: String? { get }
  var authority: Authority { get }
  var imageUrl: String? { get }
  var interests: [String]? { get }
  var job: String? { get }
  var introduce: String? { get }
  var school: String? { get }
  var blueCheck: Bool { get }
}

public enum Authority: String, Decodable {
  case anonymous = "ANONYMOUS"
  case user = "USER"
  case admin = "ADMIN"
}

public enum Gender: String, Codable {
  case male = "Male"
  case female = "Female"
}
