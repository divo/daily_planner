//
//  HourEntry.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

struct HourEntry: View, Identifiable {
  let id = UUID()
  let hour: String
  @State var text: String = ""
  
  var body: some View {
    HStack{
      Image(systemName: "clock")
      ViewUtil.smallLabel(hour).frame(width: 25)
      TextField("", text: $text).overlay(ViewUtil.divider(), alignment: .bottom)
    }
  }
}
