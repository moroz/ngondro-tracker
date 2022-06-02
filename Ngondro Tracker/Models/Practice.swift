//
//  Practice.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import Foundation

struct Practice: Identifiable {
  let table = Table("practices")
  let id = Expression<Int64>("id")
  let name = Expression<String>("name")

  func createTable(store: DataStore) throws {
    let conn = store.connection

  }
}
