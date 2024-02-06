//
//  TaskEditView.swift
//  ToDoList
//
//  Created by Печик Ирина on 06.02.2024.
//

import SwiftUI

struct TaskEditView: View {
    @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @State var selectedTaskItem: TaskItem?
    @State var name: String
    @State var desc: String
    
    init(passedTaskItem: TaskItem?) {
        if let taskItem = passedTaskItem {
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
        } else {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Task")) {
                TextField("Task Name", text: $name)
                TextField("Desc", text: $desc)
            }
            Section() {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func saveAction() {
        withAnimation {
            if selectedTaskItem == nil {
                selectedTaskItem = TaskItem(context: viewContext)
            }
            selectedTaskItem?.name = name
            selectedTaskItem?.desc = desc
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    TaskEditView(passedTaskItem: TaskItem())
}
