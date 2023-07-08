//
//  IndexView.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI
import UserNotifications

struct IndexView: View {
  @State var files = FileUtil.listDocuments()
  @State var showDetails = true
  
  init() {
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Style.primaryUIColor]
    navBarAppearance.titleTextAttributes = [.foregroundColor: Style.primaryUIColor]
  }
  
  var body: some View {
    NavigationView {
      List(files) { file in
        NavigationLink {
          PlannerView(file: file)
        } label: {
          Text(file.lastPathComponent)
        }
      }.navigationTitle("Day Planner")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: "doc.badge.plus")
              .foregroundColor(.accentColor)
              .onTapGesture {
                pushEntry()
              }
              .onLongPressGesture(minimumDuration: 0.1) {
              }
          }
        }
    }
    .accentColor(Style.primaryColor)
    .onAppear {
      NotificationUtil.requestPermission()
    }
  }
  
  func pushEntry() {
    let filename = FileUtil.dateToFilename(Date.now)
    if !FileUtil.checkFileExists(filename) {
      FileUtil.createFile(filename)
      files = FileUtil.listDocuments()
    }
  }
}

struct IndexView_Preview: PreviewProvider {
  static var previews: some View {
    IndexView()
  }
}
