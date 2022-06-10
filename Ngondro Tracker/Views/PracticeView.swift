//
//  PracticeView.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 03/06/2022.
//

import SwiftUI

struct PracticeView: View {
  @EnvironmentObject var dataStore: DataStore
  var practice: Practice
  @State private var amount: Int

  init(practice: Practice) {
    self.practice = practice
    amount = practice.currentAmount
  }

  func addCustomValue() {
    let alert = UIAlertController(title: "Add custom value", message: "", preferredStyle: .alert)

    alert.addTextField { textField in
      textField.placeholder = "Your value"
      textField.keyboardType = .numberPad
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
    alert.addAction(
      UIAlertAction(title: "Add", style: .default) { _ in
        let input = alert.textFields![0] as UITextField
        if let text = input.text, let value = Int(text) {
          try? addAmount(amount: value)
        }
      })

    if let controller = AlertHelpers.topMostViewController() {
      controller.present(alert, animated: true)
    }
  }

  func addAmount(amount newAmount: Int) throws {
    amount += newAmount
    amount = try practice.addAmount(store: dataStore, amount: newAmount)
  }

  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        if let image = practice.image {
          Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(edges: .top)
            .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
            .clipped()
        }
        Text(String(amount))
          .font(.title)
          .padding(.top, 15)
          .padding(.bottom, 10)

        HStack {
          Button {
            try? addAmount(amount: practice.malaSize)
          } label: {
            Text("+\(practice.malaSize)")
              .frame(minWidth: 0, maxWidth: .infinity)
          }
          .padding(.leading, 15)
          .padding(.trailing, 5)

          Button {
            addCustomValue()
          } label: {
            Text("+Custom")
              .frame(minWidth: 0, maxWidth: .infinity)
          }
          .padding(.trailing, 15)
          .padding(.leading, 5)
        }
        .buttonStyle(.bordered)
        .tint(.red)
        .controlSize(.large)

        Spacer()
        NavigationLink {
          HistoryView(practice: practice)
        } label: {
          Text("History")
        }
      }
    }
    .ignoresSafeArea(edges: .bottom)
    .navigationTitle(practice.name)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      NavigationLink {
        EditPractice(practice: practice, amount: $amount)
      } label: {
        Text("Edit")
      }
    }
  }
}

struct PracticeView_Previews: PreviewProvider {
  static var previews: some View {
    return PracticeView(practice: Practice.example)
      .environmentObject(DataStore())
  }
}
