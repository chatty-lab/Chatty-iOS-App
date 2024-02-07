//
//  UserAPIRepositoryProtocol.swift
//  DomainUserInterface
//
//  Created by 윤지호 on 1/29/24.
//

import Foundation
import RxSwift
import DomainCommon

public protocol UserAPIRepositoryProtocol: AnyObject {
  func saveNickname(nickname: String) -> Single<UserDataProtocol>
  func saveMBTI(mbti: String) -> Single<UserDataProtocol>
  func saveImage(imageData: Data) -> Single<UserDataProtocol>
  func saveGender(gender: String) -> Single<UserDataProtocol>
  func saveBirth(birth: String) -> Single<UserDataProtocol>
  func saveDeviceToken(deviceToken: String) -> Single<Void>

  func login(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<TokenProtocol>
  func join(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<TokenProtocol>
}
