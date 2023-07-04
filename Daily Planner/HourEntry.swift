//
//  HourEntry.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

struct HourEntry: View, Identifiable {
  var id = UUID()
  var hour: String
  @State var text: String = ""
  
  var body: some View {
    HStack{
      Image(systemName: "clock")
      ViewUtil.smallLabel(hour).frame(width: 25)
      TextField("", text: $text).overlay(ViewUtil.divider(), alignment: .bottom)
    }
  }
}

extension HourEntry: Codable {
    enum codingKeys: CodingKey {
        case id, hour, text
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        hour = try container.decode(String.self, forKey: .hour)
        text = try container.decode(String.self, forKey: .text)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hour, forKey: .hour)
        try container.encode(text, forKey: .text)
    }
}
