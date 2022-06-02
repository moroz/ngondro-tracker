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
}

class DataStore: ObservableObject {
  private(set) var connection: SQLite.Connection? = nil
  
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
    connection = try? SQLite.Connection(url.absoluteString)
    return connection
  }
}
