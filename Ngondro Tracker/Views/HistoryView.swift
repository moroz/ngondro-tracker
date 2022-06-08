//
//  HistoryView.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import SwiftUI

struct HistoryView: View {
  let practice: Practice

  @EnvironmentObject var dataStore: DataStore
  @State private var entries: [PracticeSession] = []

  func loadEntries() throws {
    do {
      entries = try PracticeSession.filterByPractice(store: dataStore, practiceId: practice.id)
    } catch {
      print(error)
    }
  }

  var body: some View {
    List(entries) { entry in
      HStack {
        Text(String(entry.amount))
        Spacer()
        Text(entry.date)
      }
    }
    .navigationTitle(Text(practice.name))
    .onAppear { try? loadEntries() }
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    let practice = Practice(id: 1, name: "Refuge", image: nil)
    return HistoryView(practice: practice)
      .environmentObject(DataStore())
  }
}
