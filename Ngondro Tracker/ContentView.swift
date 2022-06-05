//
//  ContentView.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var dataStore: DataStore

  var body: some View {
    NavigationView {
      IndexView()
    }
    .ignoresSafeArea()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(DataStore())
  }
}
