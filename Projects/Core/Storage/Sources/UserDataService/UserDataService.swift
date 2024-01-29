//
//  UserDataService.swift
//  CoreStorageInterface
//
//  Created by 윤지호 on 1/28/24.
//

import Foundation

public struct UserData {
  var nickname: String = ""
  var mobileNumber: String = ""
  var birth: String = ""
  var gender: String = ""
  var mbti: String = ""
  var address: Address? = nil
  var authority: String = ""
  var imageUrl: String = ""
  
  public struct Address {
    
  }
}

public protocol UserDataServiceProtocol {
  func getData() -> UserData
  func setData(nickname: String, mobileNumber: String, birth: String, gender: String, mbti: String, address: UserData.Address?, authority: String, imageUrl: String)
}

public final class UserDataService: UserDataServiceProtocol {
  public static let shared = UserDataService()
  private init() { }
  
  private var userData: UserData = UserData()
  
  public func getData() -> UserData {
    return userData
  }
  
  public func setData(
    nickname: String,
    mobileNumber: String,
    birth: String,
    gender: String,
    mbti: String,
    address: UserData.Address? = nil,
    authority: String,
    imageUrl: String) {
      self.userData = UserData(
        nickname: nickname,
        mobileNumber: mobileNumber,
        birth: birth,
        gender: gender,
        mbti: mbti,
        address: nil,
        authority: authority,
        imageUrl: imageUrl
      )
      print("do1 --> \(nickname)")
    }
}
