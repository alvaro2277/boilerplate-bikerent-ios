//
//  Date+Extensions.swift
//  BikeRental
//
//  Created by Alvaro Barros on 17/03/23.
//

import Foundation

extension Date {
  static var tomorrow:  Date { return Date().dayAfter }
  var dayAfter: Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
  }
  
  static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
    var dates: [Date] = []
    var date = fromDate

    while date <= toDate {
      dates.append(date)
      guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
      date = newDate
    }
    return dates
  }
}
