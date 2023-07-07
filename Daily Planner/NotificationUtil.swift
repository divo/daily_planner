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
  
  static func scheduleNotification(uuid: UUID, message: String, date: Date) {
    let content = UNMutableNotificationContent()
    content.title = message
    content.sound = UNNotificationSound.default
    
    // TODO: Check if notification already exists
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSince(Date.now), repeats: false)
    let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
  }
}
