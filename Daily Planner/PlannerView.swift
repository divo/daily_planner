
import SwiftUI

struct PlannerView: View {
  @ObservedObject var viewModel = PlannerViewModel()
  
  @Environment(\.scenePhase) var scenePhase
  
  let file: URL
  
  var body: some View {
    List {
      Group {
        ViewUtil.titleLabel("before")
        TextEditor(text: $viewModel.beforeText)
          .frame(height: 100)
          .overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("1 hour of self improvement on")
        TextField("", text: $viewModel.improvText).overlay(ViewUtil.divider(), alignment: .bottom)
        
        ViewUtil.textLabel("todo")
        ForEach($viewModel.todos, id: \.id) { todo in
          TodoView(text: todo.text, done: todo.done, editable: todo.editable)
        }
        
        
        HStack {
          Spacer()
//          Button(action: { viewModel.todo.append(Todo(id: viewModel.todo.count)) }, label: { Image(systemName: "plus") })
          Spacer()
        }
        
        ViewUtil.textLabel("schedule")
        ForEach(viewModel.hours) { hour in hour }
      }
      
      Group {
        Spacer(minLength: 20)
        ViewUtil.titleLabel("after")
        
        ViewUtil.textLabel("habbits")
//        ForEach(viewModel.habbits) { habbit in habbit }
        
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
      
    }.navigationTitle(file.lastPathComponent)
    .onAppear {
      self.viewModel = FileUtil.readFile(self.file)
    }
    .onDisappear {
      FileUtil.writeFile(self.file, viewModel: self.viewModel)
    }.onChange(of: scenePhase) { newValue in
      FileUtil.writeFile(self.file, viewModel: self.viewModel)
    }
  }
}
