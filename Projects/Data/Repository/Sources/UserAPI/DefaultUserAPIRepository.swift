//
//  DefaultUserAPIRepository.swift
//  CoreRepository
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import DataNetworkInterface
import DataRepositoryInterface
import DomainCommonInterface
import RxSwift
import Moya

public final class DefaultUserAPIRepository<RouterType: TargetType>: UserAPIRepository {
  
  private let userAPIService: any UserAPIService
  
  public init(userAPIService: any UserAPIService) {
    self.userAPIService = userAPIService
  }
  
  public func saveNickname(nickname: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.nickname(nickname: nickname)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveMBTI(mbti: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.mbti(mbti: mbti)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveImage(imageData: Data) -> Single<UserData> {
    let endPoint = UserAPIRouter.image(imageData: imageData)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveGender(gender: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.gender(gender: gender)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveBirth(birth: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.birth(birth: birth)
    return userAPIService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func changeDeviceToken(deviceToken: String) -> Single<Token> {
    let endPoint = UserAPIRouter.deviceToken(deviceToken: deviceToken)
    return userAPIService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func login(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<Token> {
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
  
  public func join(mobileNumber: String, authenticationNumber: String, deviceId: String, deviceToken: String) -> Single<Token> {
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
}
