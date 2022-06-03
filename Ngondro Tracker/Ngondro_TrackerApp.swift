//
//  Ngondro_TrackerApp.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import SwiftUI

@main
struct Ngondro_TrackerApp: App {
  @StateObject private var dataStore = DataStore()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(dataStore)
    }
  }
}
