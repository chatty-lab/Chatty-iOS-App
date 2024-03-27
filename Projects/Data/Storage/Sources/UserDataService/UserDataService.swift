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
  
  private var userData: UserDataProtocol
  private var allInterests: [Interest]
  
  private init() {
    self.userData = UserData(
      nickname: "",
      mobileNumber: "",
      authority: "",
      birth: "",
      gender: .female,
      mbti: "",
      address: "",
      imageUrl: "",
      interests: [],
      job: "",
      introduce: "",
      school: "",
      blueCheck: false
    )
    self.allInterests = []
  }
    
  public func getData() -> UserDataProtocol {
    return userData
  }
  
  public func setData(userData: UserDataProtocol) {
    var userData = userData
    userData.interests = userData.interests.map { interest in
      guard let index = allInterests.firstIndex(where: { $0.id == interest.id} ) else { return interest }
      return allInterests[index]
    }
    print("userdata - \(userData.interests)")
    self.userData = userData
  }
  
  public func saveAllInterests(interests: Interests) {
    self.allInterests = interests.interests
    self.userData.interests = userData.interests.map { interest in
      guard let index = allInterests.firstIndex(where: { $0.name == interest.name } ) else { return interest }
      return allInterests[index]
    }
  }
}
