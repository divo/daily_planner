
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

struct PlannerView: View {
  @StateObject var viewModel = PlannerViewModel()
  
  var body: some View {
   List {
     Group {
       Button {
         let encoded = try! JSONEncoder().encode(self.viewModel)
         print(String(data: encoded, encoding: .utf8))
       } label: {
         Text("Encode")
       }

     }
     
      Group {
        ViewUtil.titleLabel("before")
        TextEditor(text: $viewModel.beforeText)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("1 hour of self improvement on")
        TextField("", text: $viewModel.improvText).overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("todo")
        ForEach(viewModel.todo) { todo in todo }
        
        HStack {
          Spacer()
          Button(action: { viewModel.todo.append(Todo()) }, label: { Image(systemName: "plus") })
          Spacer()
        }
        
        ViewUtil.textLabel("schedule")
        ForEach(viewModel.hours) { hour in hour }
      }
      
      Group {
        Spacer(minLength: 20)
        ViewUtil.titleLabel("after")
        
        ViewUtil.textLabel("habbits")
        ForEach(viewModel.habbits) { habbit in habbit }
        
        Group {
          Picker(selection: $viewModel.grade) {
           ForEach(viewModel.grades, id: \.self) { item in // 4
              Text(item) // 5
            }
          } label: {
            ViewUtil.textLabel("todays grade")
          }
        }
        
        ViewUtil.textLabel("what will I do tomorrow?")
        TextEditor(text: $viewModel.tomorrow)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("evening reflection")
        TextEditor(text: $viewModel.reflection)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
      }
      
   }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    PlannerView()
  }
}
