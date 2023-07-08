//
//  NotificationUtil.swift
//  Daily Planner
//
//  Created by Steven Diviney on 07/07/2023.
//

import UserNotifications

struct NotificationUtil {
  static func requestPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
      if success {
        print("All set!")
      } else if let error = error {
        print(error.localizedDescription)
      }
    }
  }
  
  static func scheduleNotification(uuid: UUID, message: String, date: Date) -> Bool {
    removeNotification(uuid: uuid) // I'm probably updating the message
    
    let due = date.timeIntervalSince(Date.now)
    if due <= 0 {
      print("Cannot set reminder in the past!")
      return false
    }
    
    let content = UNMutableNotificationContent()
    content.title = message
    content.sound = UNNotificationSound.default
    
    // TODO: Check if notification already exists
    // Calculating a timeinterval instead of using Calender dates, what could go wrong.
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: due, repeats: false)
    let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
    return true
  }
  
  static func removeNotification(uuid: UUID) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuid.uuidString])
  }
}
