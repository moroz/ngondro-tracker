//
//  Date+Helpers.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 05/06/2022.
//

import Foundation

extension Date {
  var dateString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.string(from: self)
  }
}
