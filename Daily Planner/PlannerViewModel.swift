//
//  PlannerViewModel.swift
//  Daily Planner
//
//  Created by Steven Diviney on 04/07/2023.
//

import SwiftUI
import Combine

class PlannerViewModel: ObservableObject, Codable {
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
  }
  
  @Published var beforeText = ""
  @Published var improvText = ""
  @Published var todos: [TodoViewModel] = (0..<3).map { index in TodoViewModel(id: index) }
  @Published var boredText = ""
  @Published var hours: [HourEntry] = (8..<22).map { index in HourEntry(hour: String(index)) }
//  @Published var habbits: [Todo] = [Todo(id: 1, text: "Anki", editable: false), Todo(id: 2, text: "Reading", editable: false), Todo(id: 3, text: "Workout", editable: false), Todo(id: 4, text: "Coding", editable: false),]
  @Published var tomorrow = ""
  @Published var grade = "A"
  @Published var grades = ["A", "B", "C", "D", "F"]
  @Published var reflection = ""
  
  init() {}
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    beforeText = try container.decode(String.self, forKey: .beforeText)
    improvText = try container.decode(String.self, forKey: .improvText)
    todos = try container.decode([TodoViewModel].self, forKey: .todo)
    boredText = try container.decode(String.self, forKey: .boredText)
    hours = try container.decode([HourEntry].self, forKey: .hours)
//    habbits = try container.decode([Todo].self, forKey: .habbits)
    tomorrow = try container.decode(String.self, forKey: .tomorrow)
    grade = try container.decode(String.self, forKey: .grade)
    reflection = try container.decode(String.self, forKey: .reflection)
  }
  
  func readData(file: URL) {
//    FileUtil.updateClassFromFile(fileURL: file, classInstance: &self)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(beforeText, forKey: .beforeText)
    try container.encode(improvText, forKey: .improvText)
    try container.encode(todos, forKey: .todo)
    try container.encode(boredText, forKey: .boredText)
    try container.encode(hours, forKey: .hours)
//    try container.encode(habbits, forKey: .habbits)
    try container.encode(tomorrow, forKey: .tomorrow)
    try container.encode(grade, forKey: .grade)
    try container.encode(reflection, forKey: .reflection)
  }
}
