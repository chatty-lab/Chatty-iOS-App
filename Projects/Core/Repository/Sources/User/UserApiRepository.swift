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

//protocol UserApiRepositoryProtocol {
//  associatedtype Router: TargetType
//  var manager: APIServiceProtocol where Router == APIServiceProtocol.Router { get }
//
//  func saveNickname(nickname: String) -> Single<SaveUserDataResponseDTO>
//}
//
//public final class SaveNicknameRepository<RouterType: TargetType>: UserApiRepositoryProtocol {
//  typealias Router = UserAPIRouter
//  let manager: any APIServiceProtocol
//  
//  public init(manager: UserAPIService) {
//    self.manager = manager
//  }
//  
//  func saveNickname(nickname: String) -> Single<SaveUserDataResponseDTO> {
//    let request = UserAPIRouter.nickname(nickname: nickname)
//    return manager.request(endPoint: request, responseDTO: SaveUserDataResponseDTO.self)
//  }
//}

public protocol UserApiRepositoryProtocol {
  func saveNickname(nickname: String) -> Observable<SaveUserDataResponseDTO>
}

public final class DefaultUserApiRepositoryProtocol<RouterType: TargetType>: UserApiRepositoryProtocol {
  private let manager: UserAPIService
  
  public init(manager: UserAPIService) {
    self.manager = manager
  }
  
  public func saveNickname(nickname: String) -> Observable<SaveUserDataResponseDTO> {
    let request = UserAPIRouter.nickname(nickname: nickname)
    return manager.request(endPoint: request, responseDTO: SaveUserDataResponseDTO.self)
  }
}
