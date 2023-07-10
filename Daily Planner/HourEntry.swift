//
//  HourEntry.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

@objc class HourViewModel: NSObject, ObservableObject, Identifiable, Codable{
  let id: Int
  let notificationID: UUID
  @Published var text: String
  @Published var reminder: Bool
  
  init(id: Int, text: String = "", reminder: Bool = false) {
    self.id = id
    self.notificationID = UUID()
    self.text = text
    self.reminder = reminder
  }
  
  enum CodingKeys: CodingKey {
    case id, notificationID, text, reminder
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    notificationID = try container.decode(UUID.self, forKey: .notificationID)
    text = try container.decode(String.self, forKey: .text)
    reminder = try container.decode(Bool.self, forKey: .reminder)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(notificationID, forKey: .notificationID)
    try container.encode(text, forKey: .text)
    try container.encode(reminder, forKey: .reminder)
  }
}

struct HourView: View{
  let id: Int
  let notificationID: UUID
  @Binding var text: String
  @Binding var reminder: Bool
  @Binding var date: String //Not rendered, but need to set it in the View
  
  var body: some View {
    HStack{
      Toggle("", isOn: $reminder)
        .frame(width: 20)
        .toggleStyle(CheckToggleStyle(onSystemImage: "clock.badge.fill", offSystemImage: "clock"))
        .onChange(of: reminder) { newValue in
          // Perform an action when the toggle state changes
          print("Toggle state changed to \(newValue)")
          if newValue && text != "" {
            reminder = setReminder()
          } else {
            reminder = false
            NotificationUtil.removeNotification(id: notificationID.uuidString)
            print("Notification removed")
          }
        }
      
      ViewUtil.smallLabel(String(id)).frame(width: 25)
      
      TextField("", text: $text)
        .overlay(ViewUtil.divider(), alignment: .bottom)
        .onChange(of: text) { newValue in
          // TODO: Have reminder on by default setting here
          if newValue == "" {
            reminder = false
          } else {
            reminder = setReminder() // Fuck it
          }
        }
    }
  }
  
  func setReminder() -> Bool {
    let date = FileUtil.filenameToDate(date)
    let due = Calendar.current.date(byAdding: .hour, value: id, to: date)!
    print("Notification set for \(id) on \(date)")
    return NotificationUtil.scheduleNotification(id: notificationID.uuidString, message: text, date: due)
  }
}
