//
//  Todo.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

struct Todo: View, Identifiable {
  var id: UUID = UUID()
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

extension Todo: Codable {
  enum CodingKeys: CodingKey {
    case id, text, done, editable
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(UUID.self, forKey: .id)
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
