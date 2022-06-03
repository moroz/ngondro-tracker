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
  private(set) var connection: SQLite.Connection? = nil

  init() {
    if let _ = try? connect() {
      try? migrate()
    }
  }

  func getURL() -> URL? {
    guard
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first
    else {
      return nil
    }
    return documentsURL.appendingPathComponent(DATABASE_FILE_NAME)
  }

  func connect() throws -> SQLite.Connection? {
    guard let url = getURL() else {
      throw DatabaseError.urlError
    }
    print("Connecting to database:", url)
    do {
      connection = try SQLite.Connection(url.absoluteString)
    } catch {
      throw DatabaseError.connectionError
    }
    print("Connected to database")
    return connection
  }

  func migrate() throws {
    print("Running migrations")
    if try Practice.createTable(store: self) {
      try Practice.seed(store: self)
    }
  }
  
  func tableExists(_ tableName: String) throws -> Bool {
    guard let db = connection else {
      throw DatabaseError.connectionError
    }

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
