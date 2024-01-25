//
//  SaveNicknameUsecase.swift
//  DomainAuthInterface
//
//  Created by 윤지호 on 1/25/24.
//

import Foundation
import CoreRepository
import RxSwift

public protocol SaveNicknameUseCase {
  func requestSave(nick: String) -> Observable<String>
}

public final class DefaultSaveNicknameUseCase: SaveNicknameUseCase {
  private let userRepository: UserApiRepositoryProtocol
  
  init(userRepository: UserApiRepositoryProtocol) {
    self.userRepository = userRepository
  }
  
  public func requestSave(nick: String) -> Observable<String> {
    return userRepository.saveNickname(nickname: nick)
      .map { $0.message }
  }
}
