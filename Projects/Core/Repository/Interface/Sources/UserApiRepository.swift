//
//  UserApiRepositoryProtocol.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/30/24.
//

import Foundation
import DomainCommonInterface
import RxSwift

public protocol UserApiRepositoryProtocol: UserApiRepository {
  func saveNickname(nickname: String) -> Single<UserData>
  func saveMBTI(mbti: String) -> Single<UserData>
  func saveImage(imageData: Data) -> Single<UserData>
  func saveGender(gender: String) -> Single<UserData>
  func saveBirth(birth: String) -> Single<UserData>
  func changeDeviceToken(deviceToken: String) -> Single<Token>

  func login(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<Token>
  func join(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<Token>
}