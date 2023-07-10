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
  @State var showingPopover = false
  @State var showConfig = false
  @State var selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
  
  init() {
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Style.primaryUIColor]
    navBarAppearance.titleTextAttributes = [.foregroundColor: Style.primaryUIColor]
  }
  
  var body: some View {
    NavigationView {
      List(files.sorted(by: { l, r in
        l.lastPathComponent > r.lastPathComponent
      })) { file in
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
                showingPopover = true
              }.popover(isPresented: $showingPopover) {
                VStack {
                  DatePicker(selection: $selectedDate, in: Date.now..., displayedComponents: .date) {
                    Text("Select a date for new entry")
                  }
                  Button("Done") {
                    showingPopover = false
                    pushEntry(date: self.selectedDate)
                  }
                }.padding(20)
              }
          }
          ToolbarItem(placement: .navigationBarLeading) {
              Button {
                showConfig = true
              } label: {
                Image(systemName: "gear")
                  .popover(isPresented: $showConfig) {
                    ConfigView()
                  }
              }
            }
        }
    }
    .accentColor(Style.primaryColor)
    .onAppear {
      NotificationUtil.requestPermission()
    }
  }
  
  func pushEntry(date: Date = Date.now) {
    let filename = FileUtil.dateToFilename(date)
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
