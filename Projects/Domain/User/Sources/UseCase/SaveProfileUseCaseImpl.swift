//
//  SaveNicknameUsecase.swift
//  DomainAuthInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import DomainUserInterface
import DomainCommonInterface
import RxSwift

public final class DefaultSaveProfileUseCase: SaveProfileUseCase {
  private let userApiRepository: UserApiRepository
  private let userDataRepository: UserDataRepository

  public init(userApiRepository: UserApiRepository, userDataRepository: UserDataRepository) {
    self.userApiRepository = userApiRepository
    self.userDataRepository = userDataRepository
  }
  
  
  public func requestNicknameSave(nickname: String) -> Single<Bool> {
    let result = userApiRepository.saveNickname(nickname: nickname)
      .flatMap { userData -> Single<Bool> in
        /// 최종적으로 저장된 데이터를 UserService에 저장해 둡니다.
        /// Single로 데이터를 전달받으니 weak self  사용시 self를 찾지 못했습니다.
        /// 추후 원인을 찾아보고 해결하겠습니다.
        self.userDataRepository.saveUserData(userData: userData)
        return .just(true)
      }
    
    return result
  }
  
  public func requestProfileDataSave(
    gender: String,
    birth: String,
    imageData: Data,
    mbti: String
  ) -> Single<Bool> {
    let saveGender = userApiRepository.saveGender(gender: gender)
    let saveBirth = userApiRepository.saveBirth(birth: birth)
    let saveImageData = userApiRepository.saveImage(imageData: imageData)
    let saveMbti = userApiRepository.saveMBTI(mbti: mbti)

    return Single.zip(saveGender, saveBirth, saveImageData)
      .flatMap { _, _, _ in
        return saveMbti
      }
      .map { userData in
        /// 최종적으로 저장된 데이터를 UserService에 저장해 둡니다.
        self.userDataRepository.saveUserData(userData: userData)
        return true
      }
  }
  
  public func requestProfileData() -> Single<UserData> {
    return userDataRepository.getUserData()
  }
}