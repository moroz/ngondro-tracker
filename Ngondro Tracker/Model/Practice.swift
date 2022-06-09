//
//  Practice.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import Foundation
import SQLite

struct Practice: Identifiable, Codable {
  static let table = Table("practices")
  static let id = Expression<Int>("id")
  static let name = Expression<String>("name")
  static let image = Expression<String?>("image")
  static let targetAmount = Expression<Int>("target_amount")
  static let currentAmount = Expression<Int>("current_amount")
  static let malaSize = Expression<Int>("mala_size")
  
  static let example = Practice(id: 1, name: "Refuge", image: "refuge")
  
  var id: Int = 0
  var name: String = ""
  var image: String?
  var targetAmount: Int = 111_111
  var currentAmount: Int = 0
  var malaSize: Int = 100

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case image
    case targetAmount = "target_amount"
    case currentAmount = "current_amount"
    case malaSize = "mala_size"
  }

  init() {}

  init(
    id: Int, name: String, image: String?, targetAmount: Int = 111_111, currentAmount: Int = 0,
    malaSize: Int = 108
  ) {
    self.id = id
    self.name = name
    self.image = image
    self.targetAmount = targetAmount
    self.currentAmount = currentAmount
    self.malaSize = malaSize
  }

  static func createTable(store: DataStore) throws -> Bool {
    let db = store.db

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
    let db = store.db

    try db.transaction {
      _ = try db.run(
        "update practices set current_amount = current_amount + ? where id = ?",
        amount, id)
      _ = try PracticeSession.addAmount(store: store, practiceId: id, amount: amount)
    }

    let newAmount = try db.scalar(
      Practice.table.select(Practice.currentAmount).filter(Practice.id == self.id))

    return newAmount
  }

  static let seedData = [
    ("Refuge", "refuge"), ("Diamond Mind", "vajrasattva"), ("Mandala Offering", "mandala"),
    ("Guru Yoga", "guru-yoga"),
  ]

  static func seed(store: DataStore) throws {
    try store.db.transaction {
      for (i, (practice, img)) in seedData.enumerated() {
        var row = Self()
        row.id = i
        row.name = practice
        row.image = img
        try store.db.run(table.insert(row))
      }
    }
  }

  static func all(store: DataStore) throws -> [Practice] {
    do {
      let rows: [Self] = try store.db.prepare(table).map { row in
        return try row.decode()
      }
      return rows
    } catch {
      throw DatabaseError.queryError
    }
  }
}
