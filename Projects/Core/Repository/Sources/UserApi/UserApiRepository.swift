//
//  SaveNicknameRepository.swift
//  CoreRepositoryInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import CoreNetwork
import RxSwift
import Moya

public protocol UserApiRepositoryProtocol {
  func saveNickname(nickname: String) -> Single<SaveUserDataResponseDTO>
  func saveMBTI(mbti: String) -> Single<SaveUserDataResponseDTO>
  func saveImage(imageData: Data) -> Single<SaveUserDataResponseDTO>
  func saveGender(gender: String) -> Single<SaveUserDataResponseDTO>
  func saveBirth(birth: String) -> Single<SaveUserDataResponseDTO>
  func changeDeviceToken(deviceToken: String) -> Single<TokenResponseDTO>

  func login(request: UserSignRequestDTO) -> Single<UserSignResponseDTO>
  func join(request: UserSignRequestDTO) -> Single<UserSignResponseDTO>
}

public final class DefaultUserApiRepository<RouterType: TargetType>: UserApiRepositoryProtocol {
  
  private let userApiService: UserApiService
  
  public init(userApiService: UserApiService) {
    self.userApiService = userApiService
  }
  
  public func saveNickname(nickname: String) -> Single<SaveUserDataResponseDTO> {
    let endPoint = UserAPIRouter.nickname(nickname: nickname)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
  }
  
  public func saveMBTI(mbti: String) -> Single<SaveUserDataResponseDTO> {
    let endPoint = UserAPIRouter.mbti(mbti: mbti)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
  }
  
  public func saveImage(imageData: Data) -> Single<SaveUserDataResponseDTO> {
    let endPoint = UserAPIRouter.image(imageData: imageData)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
  }
  
  public func saveGender(gender: String) -> Single<SaveUserDataResponseDTO> {
    let endPoint = UserAPIRouter.gender(gender: gender)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
  }
  
  public func saveBirth(birth: String) -> Single<SaveUserDataResponseDTO> {
    let endPoint = UserAPIRouter.birth(birth: birth)
    return userApiService.request(endPoint: endPoint, responseDTO: SaveUserDataResponseDTO.self)
  }
  
  public func changeDeviceToken(deviceToken: String) -> Single<TokenResponseDTO> {
    let endPoint = UserAPIRouter.deviceToken(deviceToken: deviceToken)
    return userApiService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
      .map { $0.data }
  }
  
  public func login(request: UserSignRequestDTO) -> Single<UserSignResponseDTO> {
    let endPoint = UserAPIRouter.login(request: request)
    return userApiService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
  }
  
  public func join(request: UserSignRequestDTO) -> Single<UserSignResponseDTO> {
    let endPoint = UserAPIRouter.join(request: request)
    return userApiService.request(endPoint: endPoint, responseDTO: UserSignResponseDTO.self)
  }
}
