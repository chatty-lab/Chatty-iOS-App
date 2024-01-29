//
//  UserDefaultRouter.swift
//  CoreStorageInterface
//
//  Created by 윤지호 on 1/18/24.
//

import Foundation

public enum UserDefaultsReadType<T: Decodable> {
  case string
  case json(data: T.Type)
  case dict
}

public enum UserDefaultsRouter {
  case exampleString(_ string: String = "")
  case exampleInt(_ int: Int = 0)
  case exampleDecoderble(_ data: Data? = nil)
  case exampleDictionary(_ dict: Dictionary<String, Any>? = nil)
}

extension UserDefaultsRouter {
  var key: String {
    switch self {
    case .exampleString:
      return "exampleKey"
    case .exampleDecoderble:
      return "exampleKey2"
    case .exampleDictionary:
      return "exampleKey3"
    case .exampleInt:
      return "exampleKey4"
    }
  }
  
  var object: AnyObject {
    switch self {
    case .exampleString(let string):
      return string as AnyObject
    case .exampleDecoderble(let data):
      return data as AnyObject
    case .exampleDictionary(let dict):
      return dict as AnyObject
    case .exampleInt(let int):
      return int as AnyObject
    }
  }
}
