//
//  Practice.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import Foundation
import SQLite

struct Practice: Identifiable {
  static let table = Table("practices")
  static let id = Expression<Int>("id")
  static let name = Expression<String>("name")
  static let image = Expression<String?>("image")
  static let targetAmount = Expression<Int>("target_amount")
  static let currentAmount = Expression<Int>("current_amount")
  static let malaSize = Expression<Int>("mala_size")

  var id: Int = 0
  var name: String = ""
  var image: String?
  var targetAmount: Int = 111_111
  var currentAmount: Int = 0
  var malaSize: Int = 108

  init() {}

  init(id: Int, name: String, image: String?, targetAmount: Int = 111_111, currentAmount: Int = 0, malaSize: Int = 108)
  {
    self.id = id
    self.name = name
    self.image = image
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
      table.create { t in
        t.column(id, primaryKey: true)
        t.column(name, unique: true)
        t.column(image)
        t.column(targetAmount, defaultValue: 111_111)
        t.column(currentAmount, defaultValue: 0)
        t.column(malaSize, defaultValue: 108)
      })

    return true
  }

  func addAmount(store: DataStore, amount: Int) throws -> Int {
    guard let db = store.connection else {
      throw DatabaseError.connectionError
    }

    _ = try db.scalar(
      "update practices set current_amount = current_amount + ? where id = ? returning current_amount",
      amount, id)
    
    let newAmount = try db.scalar(Practice.table.select(Practice.currentAmount).filter(Practice.id == self.id))

    return newAmount
  }

  static let seedData = [
    ("Refuge", "refuge"), ("Diamond Mind", "vajrasattva"), ("Mandala Offering", "mandala"),
    ("Guru Yoga", "guru-yoga"),
  ]

  static func seed(store: DataStore) throws {
    guard let db = store.connection else {
      throw DatabaseError.connectionError
    }

    for (practice, img) in seedData {
      try db.run(table.insert(name <- practice, image <- img))
    }
  }

  static func all(store: DataStore) throws -> [Practice] {
    guard let db = store.connection else {
      throw DatabaseError.connectionError
    }

    if let rows = try? db.prepare(table) {
      return rows.map { row in
        Practice(
          id: row[id], name: row[name], image: row[image], targetAmount: row[targetAmount],
          currentAmount: row[currentAmount], malaSize: row[malaSize])
      }
    } else {
      throw DatabaseError.queryError
    }
  }
}
