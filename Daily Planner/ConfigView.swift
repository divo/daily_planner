//
//  ConfigView.swift
//  Daily Planner
//
//  Created by Steven Diviney on 08/07/2023.
//

import SwiftUI

struct ConfigView: View {
  @State var habbitsText = UserDefaults().string(forKey: "habbits") ?? ""
  @State var dayStart = UserDefaults().object(forKey: "dayStart") as? Date ?? Date.now
  @State var planningTime = UserDefaults().object(forKey: "planningTime") as? Date ?? Date.now
  @State var startNotification = true
  @State var planningNotification = true
  
  var body: some View {
    List {
      VStack {
        ViewUtil.textLabel("habbits").tint(.primary)
        ViewUtil.smallLabel("comma seperated").tint(Style.primaryColor)
        TextEditor(text: $habbitsText)
          .frame(idealHeight: 20)
          .overlay(ViewUtil.divider(), alignment: .bottom)
      }.padding(10)
        .onChange(of: habbitsText) { newValue in
          UserDefaults().set(habbitsText, forKey: "habbits")
        }
      
      HStack {
        Toggle("", isOn: $startNotification)
          .toggleStyle(CheckToggleStyle(onSystemImage: "clock.badge", offSystemImage: "clock"))
          .frame(width: 16)
        DatePicker("Day start", selection: $dayStart, displayedComponents: [.hourAndMinute])
          .datePickerStyle(CompactDatePickerStyle())
      }.onAppear {
        let calendar = Calendar.current
        let defaultTime = calendar.date(bySettingHour: 21, minute: 0, second: 0, of: Date()) ?? Date()
        planningTime = defaultTime
      }.padding(10)
      
      HStack {
        Toggle("", isOn: $planningNotification)
          .toggleStyle(CheckToggleStyle(onSystemImage: "clock.badge", offSystemImage: "clock"))
          .frame(width: 16)
        DatePicker("Planning", selection: $planningTime, displayedComponents: [.hourAndMinute])
          .datePickerStyle(CompactDatePickerStyle())
      }.onAppear {
        setTime(7, for: "dayStart", date: $dayStart)
        setTime(21, for: "planningTime", date: $planningTime)
      }.padding(10)
    }
  }
  
  func setTime(_ time: Int, for key: String, date: Binding<Date>) {
    let calendar = Calendar.current
    if UserDefaults().object(forKey: key) == nil {
      let defaultDate = calendar.date(bySettingHour: time, minute: 0, second: 0, of: Date()) ?? Date()
      date.wrappedValue = defaultDate
    }
  }
}

struct ConfigView_Preview: PreviewProvider {
  static var previews: some View {
    ConfigView()
  }
}
