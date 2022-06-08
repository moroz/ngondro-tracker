//
//  DataStore.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import Foundation
import SQLite

let DATABASE_FILE_NAME = "store.db"

enum DatabaseError: Error {
  case urlError
  case connectionError
  case queryError
}

class DataStore: ObservableObject {
  private(set) var db: SQLite.Connection

  @Published var practices: [Practice] = []

  init() {
    /* #if DEBUG */
    /*   try? FileManager.default.removeItem(at: getURL()!) */
    /* #endif */

    db = Self.connect()

    do {
      _ = try migrate()
    } catch {
      fatalError("Could not migrate database schema.")
    }
  }

  func loadPractices() throws {
    practices = try Practice.all(store: self)
  }

  private static func getURL() -> URL {
    guard
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first
    else {
      fatalError("Could not resolve database URL")
    }
    return documentsURL.appendingPathComponent(DATABASE_FILE_NAME)
  }

  private static func connect() -> SQLite.Connection {
    let url = getURL()
    #if DEBUG
      print("Connecting to SQLite database at \(url)")
    #endif
    var connection: SQLite.Connection
    do {
      connection = try SQLite.Connection(url.absoluteString)
    } catch {
      fatalError("Could not connect to the database.")
    }
    return connection
  }

  func migrate() throws {
    print("Running migrations")

    if db.userVersion == 0 {
      if try Practice.createTable(store: self) {
        try Practice.seed(store: self)
      }
      db.userVersion = 1
    }
    if db.userVersion == 1 {
      try PracticeSession.createTable(store: self)
      db.userVersion = 2
    }
  }

  func tableExists(_ tableName: String) throws -> Bool {
    let master = Table("sqlite_master")
    let name = Expression<String>("name")
    let type = Expression<String>("type")

    do {
      let result = try db.scalar(
        master.select(name.count).filter(type == "table").filter(name == tableName))
      return result == 1
    } catch {
      throw DatabaseError.queryError
    }
  }
}
