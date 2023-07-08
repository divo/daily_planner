//
//  FileUtil.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import Foundation

struct FileUtil {
  static func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // just send back the first one, which ought to be the only one
    return paths[0]
  }
 
  static func listDocuments() -> [URL] {
    try! FileManager.default.contentsOfDirectory(at: self.getDocumentsDirectory(), includingPropertiesForKeys: nil)
  }

  static func checkFileExists(_ filename: String) -> Bool {
    let url = self.getDocumentsDirectory().appendingPathComponent(filename)
    return FileManager.default.fileExists(atPath: url.path)
  }

  static func readFile(_ url: URL) -> PlannerViewModel {
    return try! JSONDecoder().decode(PlannerViewModel.self, from: Data(contentsOf: url))
  }
  
  static func update(object: PlannerViewModel, with url: URL) {
    let storedObj = try! JSONDecoder().decode(PlannerViewModel.self, from: Data(contentsOf: url))
    object.update(other: storedObj)
  }

  static func writeFile(_ url: URL, viewModel: PlannerViewModel) {
    let json = try! JSONEncoder().encode(viewModel)
    try! json.write(to: url)
  }

  static func createFile(_ filename: String) {
    let url = self.getDocumentsDirectory().appendingPathComponent(filename)
    FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
    let emptyJson = try! JSONEncoder().encode(PlannerViewModel())
    try! emptyJson.write(to: url)
  }

  static func deleteFile(_ filename: String) {
    let url = self.getDocumentsDirectory().appendingPathComponent(filename)
    try! FileManager.default.removeItem(at: url)
  }
  
  static func dateToFilename(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
  }
  
  static func filenameToDate(_ filename: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: filename)!
  }
}

extension URL: Identifiable {
  public var id: URL { self }
}
