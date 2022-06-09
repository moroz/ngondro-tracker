//
//  EditPractice.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 09/06/2022.
//

import SwiftUI

struct EditPractice: View {
  @Binding var practice: Practice
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Text("Name:")
          .font(.headline)
        TextField("Name", text: $practice.name)
          .padding(10)
          .background(Color(fromHex: "#f3f4f5"))
          .cornerRadius(5.0)
      }
      .padding(.horizontal, 15)
    }
    .navigationTitle("Edit practice")
  }
}

struct EditPractice_Previews: PreviewProvider {
    static var previews: some View {
      EditPractice(practice: .constant(Practice.example))
    }
}
