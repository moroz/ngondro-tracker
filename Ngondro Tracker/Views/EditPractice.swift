//
//  EditPractice.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import SwiftUI

struct EditPractice: View {
  var practice: Practice
  @State var draft: Practice
  
  init(practice pr: Practice) {
    practice = pr
    draft = practice
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
      Button("Save") {}
    }
  }
}

struct EditPractice_Previews: PreviewProvider {
    static var previews: some View {
      EditPractice(practice: (Practice.example))
    }
}
