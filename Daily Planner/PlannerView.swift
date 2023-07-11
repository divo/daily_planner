
import SwiftUI

struct PlannerView: View {
  @StateObject var viewModel = PlannerViewModel()
  @State var date: String = ""
  
  @Environment(\.scenePhase) var scenePhase
  @FocusState var focusedField: String?
  
  let file: URL
  
  var body: some View {
    List {
      Group {
        ViewUtil.titleLabel("before")
        TextEditor(text: $viewModel.beforeText)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
          .focused($focusedField, equals: "before")
          .onChange(of: viewModel.beforeText) { newValue in
            if newValue.last == "\t" {
              viewModel.beforeText = String(newValue.dropLast())
              focusedField = "improve"
            }
          }
        
        ViewUtil.textLabel("1 hour of self improvement on")
        TextField("Habbit, Study or Skill", text: $viewModel.improvText, onCommit: {
          focusedField = "todo_0"
        })
        .overlay(ViewUtil.divider(), alignment: .bottom)
        .focused($focusedField, equals: "improve")
        
        ViewUtil.textLabel("todo")
        ForEach($viewModel.todos, id: \.id) { todo in
          let nextTodo = (todo.id == viewModel.todos.count - 1 ? "hour_8" : "todo_\(todo.id + 1)")
          TodoView(text: todo.text, done: todo.done, editable: todo.editable, id: todo.id, nextFocus: nextTodo, focusedField: _focusedField)
        }
        
        
        HStack {
          Spacer()
          Button {
            viewModel.todos.append(TodoViewModel(id: viewModel.todos.count))
          } label: {
            Image(systemName: "plus")
          }
          Spacer()
        }
        
        ViewUtil.textLabel("schedule")
        ForEach($viewModel.hours, id: \.id) { hour in
          let nextHour = (hour.id == viewModel.hours.count - 7 ? "tomorrow" : "hour_\(hour.id + 1)")
          HourView(id: hour.id, notificationID: hour.wrappedValue.notificationID, text: hour.text, reminder: hour.reminder, date: self.$date, nextFocus: nextHour, focusedField: _focusedField)
        }
      }
      
      Group {
        Spacer(minLength: 20)
        ViewUtil.titleLabel("after")
        
        ViewUtil.textLabel("habbits")
        ForEach($viewModel.habbits, id: \.id) { habbit in
          TodoView(text: habbit.text, done: habbit.done, editable: habbit.editable, id: habbit.id, nextFocus: "", focusedField: _focusedField)
        }
 
        
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
          .focused($focusedField, equals: "tomorrow")
          .onChange(of: viewModel.tomorrow) { newValue in
            if newValue.last == "\t" {
              viewModel.beforeText = String(newValue.dropLast())
              focusedField = "reflection"
            }
          }
        
        ViewUtil.textLabel("evening reflection")
        TextEditor(text: $viewModel.reflection)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
          .focused($focusedField, equals: "reflection")
          .onChange(of: viewModel.reflection) { newValue in
            if newValue.last == "\t" {
              viewModel.beforeText = String(newValue.dropLast())
              focusedField = "before"
            }
          }
      }
      
    }.navigationTitle(file.lastPathComponent)
    .onAppear {
      viewModel.update(other: FileUtil.readFile(self.file))
      self.date = self.file.lastPathComponent
    }
    .onDisappear {
      FileUtil.writeFile(self.file, viewModel: self.viewModel)
    }.onChange(of: scenePhase) { newValue in
      FileUtil.writeFile(self.file, viewModel: self.viewModel)
    }
  }
}
