//
//  LabeledTextField.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import SwiftUI

struct LabeledTextField: View {
  var label: String
  @Binding var value: String
  var placeholder: String = ""

  var body: some View {

    VStack {
      VStack(alignment: .leading) {
        Text(label)
          .font(.headline)
          .padding(.bottom, -1)
        TextField(placeholder, text: $value)
          .padding(10)
          .background(Color(fromHex: "#f3f4f5"))
          .cornerRadius(5.0)
      }
      .padding(.horizontal, 15)
    }
    .padding(.bottom, 10)
  }
}

struct LabeledTextField_Previews: PreviewProvider {
  static var previews: some View {
    LabeledTextField(label: "Name", value: .constant("Test value"), placeholder: "Test")
      .previewLayout(.sizeThatFits)
  }
}
