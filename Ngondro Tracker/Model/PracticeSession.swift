//
//  PracticeSession.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 05/06/2022.
//

import Foundation
import SQLite

struct PracticeSession: Identifiable, Codable {
  static let sessions = Table("practice_sessions")
  static let id = Expression<Int>("id")
  static let practiceId = Expression<Int>("practice_id")
  static let date = Expression<String>("date")
  static let amount = Expression<Int>("amount")

  var id: Int
  var practiceId: Int
  var date: String
  var amount: Int

  enum codingKeys: String, CodingKey {
    case id
    case practiceId = "practice_id"
    case date
    case amount
  }

  static func createTable(store: DataStore) throws {
    let db = store.db

    let query = """
      create table practice_sessions (
         id integer primary key not null,
         practice_id integer not null,
         amount integer not null,
         date text not null,
         foreign key (practice_id) references practices (id)
      );
      create unique index practice_sessions_practice_id_date_idx on practice_sessions (practice_id, date);
      """

    try db.execute(query)
  }

  static func addAmount(store: DataStore, practiceId: Int, amount: Int) throws {
    let query = """
      insert into practice_sessions (practice_id, amount, date) values (?, ?, ?)
      on conflict (practice_id, date)
      do update set amount = amount + excluded.amount;
      """

    try store.db.run(query, practiceId, amount, Date().dateString)
  }

  static func filterByPractice(store: DataStore, practiceId: Int) throws -> [Self] {
    let query = sessions.filter(Self.practiceId == practiceId).order(date.desc)

    do {
      let rows: [Self] = try store.db.prepare(query).map { row in
        return try row.decode()
      }
      return rows
    } catch {
      throw DatabaseError.queryError
    }
  }
}
