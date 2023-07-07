//
//  Todo.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

@objc class TodoViewModel: NSObject, ObservableObject, Identifiable, Codable {
  let id: Int
  @Published var text: String
  @Published var done: Bool
  @Published var editable: Bool
  
  init(id: Int, text: String = "", done: Bool = false, editable: Bool = true) {
    self.id = id
    self.text = text
    self.done = done
    self.editable = editable
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
      Toggle("", isOn: $done)
        .toggleStyle(CheckToggleStyle())
      if editable {
        TextField("", text: $text).overlay(ViewUtil.divider(), alignment: .bottom).frame(idealWidth: .greatestFiniteMagnitude)
      } else {
        Text(text).strikethrough($done.wrappedValue)
      }
    }
  }
}

struct CheckToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    Button {
      configuration.isOn.toggle()
    } label: {
      Label {
        configuration.label
      } icon: {
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
          .foregroundStyle(configuration.isOn ? Color.accentColor : .secondary)
          .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
          .imageScale(.large)
      }
    }
    .buttonStyle(.plain)
  }
}
