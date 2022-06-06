//
//  PracticeSession.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 05/06/2022.
//

import Foundation
import SQLite

struct PracticeSession: Identifiable {
  static let sessions = Table("practice_sessions")
  static let id = Expression<Int>("id")
  static let practiceId = Expression<Int>("practice_id")
  static let date = Expression<String>("date")
  static let amount = Expression<Int>("amount")

  let id: Int
  let practiceId: Int
  let date: String = Date().dateString
  let amount: Int

  static func addAmount(store: DataStore, practiceId: Int, amount: Int) throws {
    guard let db = store.connection else {
      throw DatabaseError.connectionError
    }
  }
}
