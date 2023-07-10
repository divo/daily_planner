//
//  PlannerViewModel.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI
import Combine

@objc class PlannerViewModel: NSObject, ObservableObject, Codable {
  enum CodingKeys: CodingKey {
    case beforeText
    case improvText
    case todo
    case boredText
    case hours
    case habbits
    case tomorrow
    case grade
    case reflection
//    case forwardEx // Example on how to add properties
  }
  
  @objc @Published dynamic var beforeText = ""
  @objc @Published dynamic var improvText = ""
  @objc @Published dynamic var todos: [TodoViewModel] = (0..<3).map { index in TodoViewModel(id: index) }
  @objc @Published dynamic var boredText = ""
  @objc @Published dynamic var hours: [HourViewModel] = (8..<22).map { index in HourViewModel(id: index) }
  @objc @Published var habbits: [TodoViewModel] // [TodoViewModel(id: 1, text: "Anki", editable: false), TodoViewModel(id: 2, text: "Reading", editable: false), TodoViewModel(id: 3, text: "Workout", editable: false), TodoViewModel(id: 4, text: "Coding", editable: false),]
  @objc @Published dynamic var tomorrow = ""
  @objc @Published dynamic var grade = "A"
  @objc @Published dynamic var grades = ["A", "B", "C", "D", "F"]
  @objc @Published dynamic var reflection = ""
  
//  @objc @Published dynamic var forwardEx: String? = ""
  
  override init() {
    self.habbits = []
    super.init()
    
    if let hStrings = UserDefaults().string(forKey: "habbits")?.components(separatedBy: ", ") {
      for index in 0..<hStrings.count {
        self.habbits.append(TodoViewModel(id: index, text: hStrings[index], editable: false))
      }
    }
  }
  
  // This is kinda janky and probably makes static type fans angry
  // lol.
  func update(other: PlannerViewModel) {
    let mirror = Mirror(reflecting: other)
    for (label, _) in mirror.children {
      if let label = label {
        let uLabel = String(label.dropFirst()) // Because they are stored as _{name}. Bad
        let value = other.value(forKey: uLabel)
        if let collection = (value as? NSArray) {
          self.setValue(collection, forKey: uLabel)
        } else {
          self.setValue(value, forKey: uLabel)
        }
      }
    }
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    beforeText = try container.decode(String.self, forKey: .beforeText)
    improvText = try container.decode(String.self, forKey: .improvText)
    todos = try container.decode([TodoViewModel].self, forKey: .todo)
    boredText = try container.decode(String.self, forKey: .boredText)
    hours = try container.decode([HourViewModel].self, forKey: .hours)
    habbits = try container.decode([TodoViewModel].self, forKey: .habbits)
    tomorrow = try container.decode(String.self, forKey: .tomorrow)
    grade = try container.decode(String.self, forKey: .grade)
    reflection = try container.decode(String.self, forKey: .reflection)
//    test = try? container.decode(String.self, forKey: .forwardEx)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(beforeText, forKey: .beforeText)
    try container.encode(improvText, forKey: .improvText)
    try container.encode(todos, forKey: .todo)
    try container.encode(boredText, forKey: .boredText)
    try container.encode(hours, forKey: .hours)
    try container.encode(habbits, forKey: .habbits)
    try container.encode(tomorrow, forKey: .tomorrow)
    try container.encode(grade, forKey: .grade)
    try container.encode(reflection, forKey: .reflection)
//    try container.encode(forwardEx, forKey: .forwardEx)
  }
}
