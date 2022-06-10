//
//  EditPractice.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import SwiftUI

struct EditPractice: View {
  @EnvironmentObject var dataStore: DataStore
  @Environment(\.presentationMode) var presentationMode
  var practice: Practice
  @Binding var amount: Int
  @State var draft: Practice = Practice()

  func saveChanges() {
    if let _ = try? draft.save(store: dataStore) {
      amount = draft.currentAmount
      try? dataStore.loadPractices()
    }
    presentationMode.wrappedValue.dismiss()
  }

  var body: some View {
    ScrollView(.vertical) {
      VStack(alignment: .leading) {
        LabeledTextField(label: "Name", value: $draft.name)
        LabeledTextField(label: "Mala size", value: $draft.malaSize)
        LabeledTextField(label: "Current amount", value: $draft.currentAmount)
        LabeledTextField(label: "Target amount", value: $draft.targetAmount)
      }
    }
    .navigationTitle("Edit practice")
    .toolbar {
      Button("Save") { saveChanges() }
    }
    .onAppear {
      draft = practice
    }
  }
}

struct EditPractice_Previews: PreviewProvider {
  static var previews: some View {
    EditPractice(practice: Practice.example, amount: .constant(2137))
  }
}
