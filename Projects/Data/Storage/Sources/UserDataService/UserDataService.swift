//
//  UserDataService.swift
//  CoreStorageInterface
//
//  Created by 윤지호 on 1/28/24.
//

import Foundation
import DomainCommonInterface
import DataStorageInterface

public final class UserDataService: UserDataServiceProtocol {
  public static let shared = UserDataService()
  private init() { 
    self.userData = UserData(
      nickname: "",
      mobileNumber: "",
      birth: "",
      gender: "",
      mbti: "",
      authority: "",
      imageUrl: ""
    )
  }
  
  private var userData: UserData
  
  public func getData() -> UserData {
    return userData
  }
  
  public func setData(userData: UserData) {
      self.userData = userData
    }
}
