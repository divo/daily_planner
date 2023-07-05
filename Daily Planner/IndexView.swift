//
//  IndexView.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

struct Style {
  static let primaryColor = Color(red: 105 / 255, green: 87 / 255, blue: 232 / 255)
  static let primaryUIColor = UIColor(red: 105 / 255, green: 87 / 255, blue: 232 / 255, alpha: 1.0)
}

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
            Button {
              pushEntry()
            } label: {
              Image(systemName: "doc.badge.plus")
            }
          }
        }
    }
    .accentColor(Style.primaryColor)
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
