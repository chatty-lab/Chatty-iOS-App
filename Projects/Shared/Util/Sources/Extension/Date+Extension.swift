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
}
