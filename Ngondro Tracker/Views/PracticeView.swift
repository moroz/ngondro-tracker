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
    GeometryReader { geometry in
      VStack {
        if let practice = practice {
          if let image = practice.image {
            Image(image)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .ignoresSafeArea(edges: .top)
              .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
              .clipped()
          }
          Spacer()
          Text(practice.name)
            .font(.title2)
          Text(String(practice.currentAmount))
            .font(.system(size: 50.0))
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(.top, 10.0)
          Button("+\(practice.malaSize)") {}
            .buttonStyle(.bordered)
            .tint(.red)
            .controlSize(.large)
          Spacer()
        } else {
          Text("Loading...")
        }
      }
    }
    .onAppear { try? dataStore.loadPractices() }
    .navigationTitle(practice?.name ?? "")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct PracticeView_Previews: PreviewProvider {
  static var previews: some View {
    PracticeView(id: 1)
      .environmentObject(DataStore())
  }
}
