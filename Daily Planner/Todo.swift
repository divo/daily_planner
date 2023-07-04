//
//  Todo.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

struct Todo: View, Identifiable {
  let id = UUID()
  @State var text: String = ""
  @State var done: Bool = false
  @State var editable: Bool = true
  
  var body: some View {
    HStack {
      Button {
        done.toggle()
      } label: {
        if done {
          Image(systemName: "checkmark.square")
        } else {
          Image(systemName: "square")
        }
      }
      if editable {
        TextField("", text: $text).overlay(ViewUtil.divider(), alignment: .bottom)
      } else {
        Text(text)
      }
    }
  }
}
