//
//  PracticeView.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import SwiftUI

struct PracticeView: View {
  @EnvironmentObject var dataStore: DataStore
  let id: Int

  var practice: Practice? {
    dataStore.practices.first { $0.id == id }
  }

  var body: some View {
    return VStack {
      if let practice = practice {
        Text(practice.name)
          .font(.title3)
        Text(String(practice.currentAmount))
          .font(.title2)
      } else {
        Text("Loading...")
      }
    }
    .onAppear { try? dataStore.loadPractices() }
  }
}

struct PracticeView_Previews: PreviewProvider {
  static var previews: some View {
    PracticeView(id: 1)
      .environmentObject(DataStore())
  }
}
