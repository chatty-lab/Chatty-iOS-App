//
//  UserDataService.swift
//  DataStorage
//
//  Created by 윤지호 on 1/28/24.
//

import Foundation
import DataStorageInterface
import DomainUser
import DomainUserInterface

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
      address: "",
      imageUrl: "",
      interests: [],
      job: "",
      introduce: "",
      school: "",
      blueCheck: false
    )
  }
  
  private var userData: UserDataProtocol
  
  public func getData() -> UserDataProtocol {
    return userData
  }
  
  public func setData(userData: UserDataProtocol) {
    self.userData = userData
  }
}
