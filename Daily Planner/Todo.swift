//
//  Todo.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

class TodoViewModel: ObservableObject, Identifiable, Codable {
  let id: Int
  @Published var text: String = ""
  @Published var done: Bool = false
  @Published var editable: Bool = true
  
  init(id: Int) {
    self.id = id
  }
  
  enum CodingKeys: CodingKey {
    case id, text, done, editable
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    text = try container.decode(String.self, forKey: .text)
    done = try container.decode(Bool.self, forKey: .done)
    editable = try container.decode(Bool.self, forKey: .editable)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(text, forKey: .text)
    try container.encode(done, forKey: .done)
    try container.encode(editable, forKey: .editable)
  }

}

struct TodoView: View {
  @Binding var text: String
  @Binding var done: Bool
  @Binding var editable: Bool
  
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
