//
//  IndexView.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI

struct IndexView: View {
  @State var files = FileUtil.listDocuments()
  @State var showDetails = true
  
  var body: some View {
    NavigationView {
      List(files) { file in
        NavigationLink {
          PlannerView(file: file)
        } label: {
          Text(file.lastPathComponent)
        }
        Button("Clear") {
          FileUtil.deleteFile(FileUtil.dateToFilename(Date.now))
          files = FileUtil.listDocuments()
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
