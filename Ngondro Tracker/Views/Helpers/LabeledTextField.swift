//
//  LabeledTextField.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import SwiftUI

struct AppTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<_Label>) -> some View {
    configuration
      .padding(10)
      .background(Color(UIColor.systemGray5))
      .cornerRadius(5.0)
  }
}

struct LabeledTextField<V>: View {
  var label: String
  @Binding var value: V
  var placeholder: String = ""

  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Text(label)
          .font(.headline)
          .padding(.bottom, -1)
        switch $value {
        case is Binding<Int>:
          TextField(placeholder, value: $value, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .textFieldStyle(AppTextFieldStyle())
        default:
          TextField(placeholder, text: $value as! Binding<String>)
            .textFieldStyle(AppTextFieldStyle())
        }
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
