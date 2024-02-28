//
//  DefaultUserAPIRepository.swift
//  DataRepository
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import RxSwift
import Moya
import DataNetworkInterface
import DataRepositoryInterface
import DomainUserInterface
import DomainCommon

public final class DefaultUserAPIRepository: UserAPIRepository {
  
  private let userAPIService: any UserAPIService
  private let profileAPIService: any ProfileAPIService
  
  public init(userAPIService: any UserAPIService, profileAPIService: any ProfileAPIService) {
    self.userAPIService = userAPIService
    self.profileAPIService = profileAPIService
  }
  
  public func saveNickname(nickname: String) -> Single<UserDataProtocol> {
    let endPoint = UserAPIRouter.nickname(nickname: nickname)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveMBTI(mbti: String) -> Single<UserDataProtocol> {
    let endPoint = UserAPIRouter.mbti(mbti: mbti)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveImage(imageData: Data) -> Single<UserDataProtocol> {
    let endPoint = UserAPIRouter.image(imageData: imageData)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveGender(gender: String) -> Single<UserDataProtocol> {
    let endPoint = UserAPIRouter.gender(gender: gender)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveBirth(birth: String) -> Single<UserDataProtocol> {
    let endPoint = UserAPIRouter.birth(birth: birth)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveDeviceToken(deviceToken: String) -> Single<Void> {
    let endPoint = UserAPIRouter.deviceToken(deviceToken: deviceToken)
    return userAPIService.request(endPoint: endPoint, responseDTO: EmptyResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func login(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<TokenProtocol> {
    let request = UserSignRequestDTO(
      mobileNumber: mobileNumber,
      authenticationNumber: authenticationNumber,
      deviceId: deviceId,
      deviceToken: deviceToken
    )
    let endPoint = UserAPIRouter.login(request: request)
    return userAPIService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func join(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<TokenProtocol> {
    let request = UserSignRequestDTO(
      mobileNumber: mobileNumber,
      authenticationNumber: authenticationNumber,
      deviceId: deviceId,
      deviceToken: deviceToken
    )
    let endPoint = UserAPIRouter.join(request: request)
    return userAPIService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func myProfile() -> Single<UserDataProtocol> {
    return userAPIService.request(endPoint: .myProfile, responseDTO: UserDataReponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func someoneProfile(userId: Int) -> Single<UserProfileProtocol> {
    return profileAPIService.request(endPoint: .profile(userId: userId), responseDTO: UserProfileResponseDTO.self)
      .map { $0.toDomain() }
  }
}
