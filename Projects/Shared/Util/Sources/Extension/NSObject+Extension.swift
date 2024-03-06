//
//  NSObject+Extension.swift
//  SharedUtil
//
//  Created by HUNHIE LEE on 2/9/24.
//

import Foundation

public extension NSObject {
  var identifier: String {
    return String(describing: self.description)
  }
}
