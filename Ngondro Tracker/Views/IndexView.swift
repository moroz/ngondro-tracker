//
//  IndexView.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import SwiftUI

struct IndexView: View {
  @EnvironmentObject private var dataStore: DataStore

  var body: some View {
    Group {
      if dataStore.practices.count == 0 {
        Text("Loading...")
      } else {
        List(dataStore.practices) { row in
          NavigationLink(row.name, destination: PracticeView(id: row.id))
        }
        .navigationTitle("Practices")
      }
    }
    .onAppear { try? dataStore.loadPractices() }
  }
}

struct IndexView_Previews: PreviewProvider {
  static var previews: some View {
    IndexView()
      .environmentObject(DataStore())
  }
}
