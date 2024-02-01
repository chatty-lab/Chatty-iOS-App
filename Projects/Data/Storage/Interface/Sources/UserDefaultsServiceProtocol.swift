//
//  UserDefaultsServiceProtocol.swift
//  CoreStorageInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import RxSwift

public protocol UserDefaultsServiceProtocol: AnyObject {
  func creat(type: UserDefaultsRouter)
  func read<T>(type: UserDefaultsRouter) -> Observable<T?>
  func delete(type: UserDefaultsRouter)
}
