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

  func saveSchool(school: String) -> Single<UserDataProtocol>
  func saveJob(job: String) -> Single<UserDataProtocol>
  func saveIntroduce(introduce: String) -> Single<UserDataProtocol>
  func saveInterests(interest: [Interest]) -> Single<UserDataProtocol>
  func saveAddress(address: String) -> Single<UserDataProtocol>
  
  func login(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<TokenProtocol>
  func join(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<TokenProtocol>
  
  func getProfile() -> Single<UserDataProtocol>
  
  func getInterests() -> Single<Interests>
}
