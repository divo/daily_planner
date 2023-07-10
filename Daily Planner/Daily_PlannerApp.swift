//
//  Daily_PlannerApp.swift
//  Daily Planner
//
//  Created by Steven Diviney on 26/06/2023.
//

import SwiftUI

@main
struct Daily_PlannerApp: App {
  init () {
    FileUtil.setDriveURL()
  }
  
  var body: some Scene {
    WindowGroup {
      IndexView()
    }
  }
}
