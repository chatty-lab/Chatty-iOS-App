//
//  DateFormatter+Extension.swift
//  SharedUtil
//
//  Created by 윤지호 on 2/23/24.
//

import Foundation

extension Date {
  private static let dateFormatter = DateFormatter()
  
  /// "yyyy-MM-dd" -> Date
  public func toDate(_ yearMonthDay: String) -> Date {
    let dateFormatter = Self.dateFormatter
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let convertedDate = dateFormatter.date(from: yearMonthDay) else {
      return Date.now
    }
    return convertedDate
  }
  
  /// Date -> "yyyy-MM-dd"
  public func toStringYearMonthDay() -> String {
    let dateFormatter = Self.dateFormatter
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let convertedDate = dateFormatter.string(from: self)
    return convertedDate
  }
  
  public func toCustomString(format: DateFormatType) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = format.formatString
    return formatter.string(from: self)
  }
  
  public enum DateFormatType {
    case ahhmm
    
    var formatString: String {
      switch self {
      case .ahhmm:
        return "a hh:mm"
      }
    }
  }
}
