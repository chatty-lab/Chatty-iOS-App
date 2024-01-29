//
//  SaveNicknameRepository.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import CoreNetwork
import CoreNetworkInterface
import CoreRepositoryInterface
import DomainCommonInterface
import RxSwift
import Moya

public final class DefaultUserApiRepository<RouterType: TargetType>: UserApiRepositoryProtocol {
  
  private let userApiService: UserApiService
  
  public init(userApiService: UserApiService) {
    self.userApiService = userApiService
  }
  
  public func saveNickname(nickname: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.nickname(nickname: nickname)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveMBTI(mbti: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.mbti(mbti: mbti)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveImage(imageData: Data) -> Single<UserData> {
    let endPoint = UserAPIRouter.image(imageData: imageData)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveGender(gender: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.gender(gender: gender)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func saveBirth(birth: String) -> Single<UserData> {
    let endPoint = UserAPIRouter.birth(birth: birth)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
      .map { $0.toDomain() }
  }
  
  public func changeDeviceToken(deviceToken: String) -> Single<Token> {
    let endPoint = UserAPIRouter.deviceToken(deviceToken: deviceToken)
    return userApiService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
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
    return userApiService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
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
    return userApiService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
      .map { $0.toDomain() }
  }
}
