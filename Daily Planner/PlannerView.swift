
import SwiftUI

struct PlannerView: View {
  @State var beforeText = ""
  @State var improvText = ""
  @State var todo: [Todo] = (0..<3).map { _ in Todo() }
  @State var boredText = ""
  @State var hours: [HourEntry] = (8..<22).map { index in HourEntry(hour: String(index)) }
  @State var habbits: [Todo] = [Todo(text: "Anki", editable: false), Todo(text: "Reading", editable: false), Todo(text: "Workout", editable: false), Todo(text: "Coding", editable: false),]
  @State var tomorrow = ""
  @State var grade = "A"
  @State var grades = ["A", "B", "C", "D", "F"]
  @State var reflection = ""
  
  var body: some View {
    List {
      Group {
        ViewUtil.titleLabel("before")
        TextEditor(text: $beforeText)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("1 hour of self improvement on")
        TextField("", text: $improvText).overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("todo")
        ForEach(todo) { todo in todo }
        
        HStack {
          Spacer()
          Button(action: { todo.append(Todo()) }, label: { Image(systemName: "plus") })
          Spacer()
        }
        
        ViewUtil.textLabel("schedule")
        ForEach(hours) { hour in hour }
      }
      
      Group {
        Spacer(minLength: 20)
        ViewUtil.titleLabel("after")
        
        ViewUtil.textLabel("habbits")
        ForEach(habbits) { habbit in habbit }
        
        Group {
          Picker(selection: $grade) {
           ForEach(grades, id: \.self) { item in // 4
              Text(item) // 5
            }
          } label: {
            ViewUtil.textLabel("todays grade")
          }
        }
        
        ViewUtil.textLabel("what will I do tomorrow?")
        TextEditor(text: $tomorrow)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("evening reflection")
        TextEditor(text: $reflection)
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
