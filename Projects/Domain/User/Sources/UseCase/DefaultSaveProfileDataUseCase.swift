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
  
  public func excute(gender: String, birth: String, imageData: Data, mbti: String) -> Single<Bool> {
    let saveGender = userAPIRepository.saveGender(gender: gender)
    let saveBirth = userAPIRepository.saveBirth(birth: birth)
    let saveImageData = userAPIRepository.saveImage(imageData: imageData)
    let saveMbti = userAPIRepository.saveMBTI(mbti: mbti)

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
}
