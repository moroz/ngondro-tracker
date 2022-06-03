//
//  IndexView.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import SwiftUI

struct IndexView: View {
  @EnvironmentObject private var dataStore: DataStore
  @State private var loading: Bool = true
  @State private var practices: [Practice] = []

  func loadData() {
    if let results = try? Practice.all(store: dataStore) {
      practices = results
      loading = false
    }
  }

  var body: some View {
    Group {
      if loading {
        Text("Loading...")
      }else {
        List {
          ForEach(practices, id: \.id ) { row in
            Text(row.name)
          }
        }
      }
    }
      .onAppear { loadData() }
  }
}

struct IndexView_Previews: PreviewProvider {
  static var previews: some View {
    IndexView()
  }
}
