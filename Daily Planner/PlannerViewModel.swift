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
  @Published var todo: [Todo] = (0..<3).map { _ in Todo() }
  @Published var boredText = ""
  @Published var hours: [HourEntry] = (8..<22).map { index in HourEntry(hour: String(index)) }
  @Published var habbits: [Todo] = [Todo(text: "Anki", editable: false), Todo(text: "Reading", editable: false), Todo(text: "Workout", editable: false), Todo(text: "Coding", editable: false),]
  @Published var tomorrow = ""
  @Published var grade = "A"
  @Published var grades = ["A", "B", "C", "D", "F"]
  @Published var reflection = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $beforeText
      .sink { [weak self] change in
        self?.objectWillChange.send()
        // Perform any additional actions here
      }
      .store(in: &cancellables)
  }
  
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    beforeText = try container.decode(String.self, forKey: .beforeText)
    improvText = try container.decode(String.self, forKey: .improvText)
    todo = try container.decode([Todo].self, forKey: .todo)
    boredText = try container.decode(String.self, forKey: .boredText)
    hours = try container.decode([HourEntry].self, forKey: .hours)
    habbits = try container.decode([Todo].self, forKey: .habbits)
    tomorrow = try container.decode(String.self, forKey: .tomorrow)
    grade = try container.decode(String.self, forKey: .grade)
    reflection = try container.decode(String.self, forKey: .reflection)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(beforeText, forKey: .beforeText)
    try container.encode(improvText, forKey: .improvText)
    try container.encode(todo, forKey: .todo)
    try container.encode(boredText, forKey: .boredText)
    try container.encode(hours, forKey: .hours)
    try container.encode(habbits, forKey: .habbits)
    try container.encode(tomorrow, forKey: .tomorrow)
    try container.encode(grade, forKey: .grade)
    try container.encode(reflection, forKey: .reflection)
  }
}
