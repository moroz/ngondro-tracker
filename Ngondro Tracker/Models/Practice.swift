//
//  Practice.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import Foundation
import SQLite

struct Practice: Identifiable {
  static let practices = Table("practices")
  static let id = Expression<Int>("id")
  static let name = Expression<String>("name")
  static let targetAmount = Expression<Int>("target_amount")
  static let currentAmount = Expression<Int>("current_amount")
  static let malaSize = Expression<Int>("mala_size")

  let id: Int
  let name: String
  let targetAmount: Int
  let currentAmount: Int
  let malaSize: Int

  init(id: Int, name: String, targetAmount: Int, currentAmount: Int, malaSize: Int) {
    self.id = id
    self.name = name
    self.targetAmount = targetAmount
    self.currentAmount = currentAmount
    self.malaSize = malaSize
  }

  static func createTable(store: DataStore) throws -> Bool {
    guard let db = store.connection else {
      throw DatabaseError.connectionError
    }
    guard let exists = try? store.tableExists("practices"), !exists else {
      return false
    }

    try db.run(
      practices.create { t in
        t.column(id, primaryKey: true)
        t.column(name, unique: true)
        t.column(targetAmount, defaultValue: 111_111)
        t.column(currentAmount, defaultValue: 0)
        t.column(malaSize, defaultValue: 108)
      })
    
    return true
  }
  
  static let seedData = ["Refuge", "Diamond Mind", "Mandala Offering", "Guru Yoga"]
  
  static func seed(store: DataStore) throws {
    guard let db = store.connection else {
      throw DatabaseError.connectionError
    }
    
    for practice in seedData {
      try db.run(practices.insert(name <- practice))
    }
  }
  
  static func all(store: DataStore) throws -> [Practice] {
    guard let db = store.connection else {
      throw DatabaseError.connectionError
    }

    if let rows = try? db.prepare(practices) {
      return rows.map { row in
        Practice(
          id: row[id], name: row[name], targetAmount: row[targetAmount],
          currentAmount: row[currentAmount], malaSize: row[malaSize])
      }
    } else {
      throw DatabaseError.queryError
    }
  }
}
