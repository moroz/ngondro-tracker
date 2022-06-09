//
//  Color+Helpers.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import Foundation
import SwiftUI

private func normalizeHex(_ hex: String) -> String? {
  guard hex.count == 6 || hex.count == 7 else {
    return nil
  }

  if hex.starts(with: "#") {
    let start = hex.index(hex.startIndex, offsetBy: 1)
    return String(hex[start...])
  }

  return hex
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
