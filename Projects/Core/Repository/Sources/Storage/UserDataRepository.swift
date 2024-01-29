//
//  UserDataRepository.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import CoreStorage
import CoreNetwork
import RxSwift

public protocol UserDataRepositoryProtocol {
  func saveUserData(userData: UserDataReponseDTO)
  func getUserData() -> Single<UserData>
}

public final class DefaultUserDataRepository: UserDataRepositoryProtocol {
  private let userDataService: UserDataService
  
  public init(userDataService: UserDataService) {
    self.userDataService = userDataService
  }
  
  public func saveUserData(userData: UserDataReponseDTO) {
    userDataService.setData(
      nickname: userData.nickname,
      mobileNumber: userData.mobileNumber,
      birth: userData.birth,
      gender: userData.gender,
      mbti: userData.mbti,
      authority: userData.authority,
      imageUrl: userData.imageUrl
    )
  }
  
  public func getUserData() -> Single<UserData> {
    let data = userDataService.getData()
    return .just(data)
  }
}
