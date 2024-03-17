//
//  UserDefaultsRouter.swift
//  DataStorageInterface
//
//  Created by HUNHIE LEE on 2/1/24.
//

import Foundation
import DomainCommon

public enum UserDefaualtsReadType<T: Decodable> {
  case string
  case json(data: T.Type)
  case dict
}

///case exampleString(_ string: String = "")
///case exampleInt(_ int: Int = 0)
///case exampleDecoderble(_ data: Data? = nil)
///case exampleDictionary(_ dict: Dictionary<String, Any>? = nil)
public enum UserDefaultsRouter {
  case matchConditionState(_ state: Data)

  public static func toRouterCase(type: UserDefaultsCase) -> Self {
    switch type {
    case .matchConditionState(let state):
      return .matchConditionState(state ?? Data())
    }
  }
}

public extension UserDefaultsRouter {
  var key: String {
    switch self {
    case .matchConditionState:
      return "matchConditionState"
    }
  }
  
///case .exampleString(let string):
///  return string as AnyObject
///case .exampleDecoderble(let data):
///  return data as AnyObject
///case .exampleDictionary(let dict):
///  return dict as AnyObject
///case .exampleInt(let int):
///  return int as AnyObject
  var object: AnyObject {
    switch self {
    case .matchConditionState(let data):
      return data as AnyObject
    }
  }
}
