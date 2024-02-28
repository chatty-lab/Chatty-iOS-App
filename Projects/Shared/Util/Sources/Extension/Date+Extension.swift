//
//  Date+Extension.swift
//  SharedUtil
//
//  Created by HUNHIE LEE on 2/24/24.
//

import Foundation

public enum DateFormatType {
  case ahhmm
  
  var formatString: String {
    switch self {
    case .ahhmm:
      return "a hh:mm"
    }
  }
}

public extension Date {
  func toCustomString(format: DateFormatType) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = format.formatString
    return formatter.string(from: self)
  }
}
