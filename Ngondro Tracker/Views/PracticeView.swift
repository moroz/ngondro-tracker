//
//  PracticeView.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import SwiftUI

struct PracticeView: View {
  @EnvironmentObject var dataStore: DataStore
  let practice: Practice
  @State private var amount: Int

  init(practice: Practice) {
    self.practice = practice
    amount = practice.currentAmount
  }

  func addAmount(amount newAmount: Int) throws {
    amount = try practice.addAmount(store: dataStore, amount: newAmount)
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
        if let image = practice.image {
          Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(edges: .top)
            .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
            .clipped()
        }
        Spacer()
        Text(String(amount))
          .font(.system(size: 40.0))
          .fontWeight(.medium)
          .multilineTextAlignment(.center)
          .padding(.top, 10.0)
        Button("+\(practice.malaSize)") {
          try? addAmount(amount: practice.malaSize)
        }
        .buttonStyle(.bordered)
        .tint(.red)
        .controlSize(.large)

        Spacer()
      }
    }
    .navigationTitle(practice.name)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct PracticeView_Previews: PreviewProvider {
  static var previews: some View {
    let practice = Practice(id: 1, name: "Refuge", image: "refuge")
    return PracticeView(practice: practice)
      .environmentObject(DataStore())
  }
}
