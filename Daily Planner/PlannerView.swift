
import SwiftUI

struct PlannerView: View {
  @State var viewModel = PlannerViewModel()
  let file: URL
  
  var body: some View {
   List {
     Group {
       Button {
         FileUtil.writeFile(self.file, viewModel: self.viewModel)
       } label: {
         Text("Write")
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
      
   }.onAppear {
     self.viewModel = FileUtil.readFile(self.file)
   }
  }
}
