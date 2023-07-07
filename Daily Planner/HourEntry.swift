//
//  HourEntry.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

@objc class HourViewModel: NSObject, ObservableObject, Identifiable, Codable{
  let id: Int
  @Published var text: String
  
  init(id: Int, text: String = "") {
    self.id = id
    self.text = text
  }

  enum CodingKeys: CodingKey {
    case id, text
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    text = try container.decode(String.self, forKey: .text)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(text, forKey: .text)
  }
}

struct HourView: View{
  let id: Int
  @Binding var text: String
  
  var body: some View {
    HStack{
      Image(systemName: "clock")
      ViewUtil.smallLabel(String(id)).frame(width: 25)
      TextField("", text: $text).overlay(ViewUtil.divider(), alignment: .bottom)
    }
  }
}
