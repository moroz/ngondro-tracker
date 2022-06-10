//
//  Color+Helpers.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import Foundation
import SwiftUI

private let regex = try! NSRegularExpression(pattern: "[^A-Fa-f0-9]")

private func normalizeHex(_ hex: String) -> String? {
  // First, remove irrelevant characters from the string
  let range = NSRange(location: 0, length: hex.count)
  let replaced = regex.stringByReplacingMatches(in: hex, range: range, withTemplate: "")

  // duplicate digits, if needed
  if replaced.count == 3 {
    return replaced.map { char in String(repeating: char, count: 2) }.joined()
  }

  if replaced.count == 6 {
    return replaced
  }

  return nil
}

extension Color {
  init(fromHex hex: String) {
    guard let normalized = normalizeHex(hex), let int = Int(normalized, radix: 16) else {
      fatalError("Invalid hex string: \(hex)")
    }

    let red = Double((int & 0xFF0000) >> 16) / 255.0
    let green = Double((int & 0xFF00) >> 8) / 255.0
    let blue = Double(int & 0xFF) / 255.0

    self.init(red: red, green: green, blue: blue)
  }
}
