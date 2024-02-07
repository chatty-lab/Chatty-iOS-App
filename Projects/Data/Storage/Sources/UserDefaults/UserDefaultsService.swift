//
//  UserDefaultsService.swift
//  DataStorage
//
//  Created by 윤지호 on 1/18/24.
//

import Foundation
import DataStorageInterface
import RxSwift

public final class UserDefaultsService: UserDefaultsServiceProtocol {
  public init() { }
  
  public func creat(type: UserDefaultsRouter) {
    UserDefaults.standard.setValue(type.object, forKey: type.key)
  }
  
  /// JSON은 Data타입으로 encoding해서 받고 Data타입으로 반환합니다.
  /// 반환된 value값은 옵셔널 타입으로 타입 캐스팅 해서 사용할 수 있습니다
  /// 예시) service.read(type: .exampleDictionary()) as [String: Any]?
  public func read<T>(type: UserDefaultsRouter) -> Observable<T?> {
    let data = UserDefaults.standard.object(forKey: type.key)
    guard data != nil else {
      return .just(nil)
    }
    return .just(data as? T)
  }
  
  public func delete(type: UserDefaultsRouter) {
    UserDefaults.standard.removeObject(forKey: type.key)
  }
}
