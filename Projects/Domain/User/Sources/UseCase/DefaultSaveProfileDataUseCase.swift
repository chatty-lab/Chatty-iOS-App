//
//  DefaultSaveProfileDataUseCase.swift
//  DomainUser
//
//  Created by 윤지호 on 2/19/24.
//

import Foundation
import DomainUserInterface
import RxSwift

public final class DefaultSaveProfileDataUseCase: SaveProfileDataUseCase {
  private let userAPIRepository: any UserAPIRepositoryProtocol
  private let userDataRepository: any UserDataRepositoryProtocol
  
  public init(userAPIRepository: any UserAPIRepositoryProtocol, userDataRepository: any UserDataRepositoryProtocol) {
    self.userAPIRepository = userAPIRepository
    self.userDataRepository = userDataRepository
  }
  
  public func excute(gender: String, birth: String, imageData: Data?, interests: [Interest], mbti: String) -> Single<Bool> {
    let saveGender = userAPIRepository.saveGender(gender: gender)
    let saveBirth = userAPIRepository.saveBirth(birth: birth)
    let saveInterests = userAPIRepository.saveInterests(interest: interests)
    let saveMbti = userAPIRepository.saveMBTI(mbti: mbti)

    /// 회원가입 시 저장하고 변하지 않는 데이터들은 MBTI저장을 기점으로 막히게되기에
    /// 다른 데이터 저장 이후 MBTI를 마지막으로 저장
    if let imageData = imageData {
      let saveImageData = userAPIRepository.saveImage(imageData: imageData)
      return Single.zip(saveGender, saveBirth, saveImageData, saveInterests)
        .flatMap { _, _, _, _ in
          return saveMbti
        }
        .map { userData in
          /// 최종적으로 저장된 데이터를 UserService에 저장해 둡니다.
          self.userDataRepository.saveUserData(userData: userData)
          return true
        }
    } else {
      return Single.zip(saveGender, saveBirth, saveInterests)
        .flatMap { _, _, _ in
          return saveMbti
        }
        .map { userData in
          /// 최종적으로 저장된 데이터를 UserService에 저장해 둡니다.
          self.userDataRepository.saveUserData(userData: userData)
          return true
        }
    }


  }
}
