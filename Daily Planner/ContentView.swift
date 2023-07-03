
import SwiftUI

struct ViewUtil {
  static func dividerLine() -> some View {
    Divider()
      .frame(height: 1)
      .padding(.horizontal, 30)
      .background(.black)
  }
  
  static func textLabel(_ text: String) -> some View {
    Text(text)
      .font(.title2)
      .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
  }
  
  static func titleLabel(_ text: String) -> some View {
   Text(text)
      .font(.title)
      .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
  }
  
  static func smallLabel(_ text: String) -> some View {
    Text(text)
      .font(.subheadline)
      .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
  }
  
  static func divider() -> some View {
    Rectangle()
      .frame(height: 1)
      .foregroundColor(.primary)
  }
}

struct Todo: View, Identifiable {
  let id = UUID()
  @State var text: String = ""
  @State var done: Bool = false
  @State var editable: Bool = true
  
  var body: some View {
    HStack {
      Button {
        done.toggle()
      } label: {
        if done {
          Image(systemName: "checkmark.square")
        } else {
          Image(systemName: "square")
        }
      }
      if editable {
        TextField("", text: $text).overlay(ViewUtil.divider(), alignment: .bottom)
      } else {
        Text(text)
      }
    }
  }
}

struct HourEntry: View, Identifiable {
  let id = UUID()
  let hour: String
  @State var text: String = ""
  
  var body: some View {
    HStack{
      Image(systemName: "clock")
      ViewUtil.smallLabel(hour).frame(width: 25)
      TextField("", text: $text).overlay(ViewUtil.divider(), alignment: .bottom)
    }
  }
}

struct ContentView: View {
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
        
        ViewUtil.textLabel("what will I do tomrrow?")
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
    ContentView()
  }
}
