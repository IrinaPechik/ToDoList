//
//  ContentView.swift
//  ToDoList
//
//  Created by Печик Ирина on 06.02.2024.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(items) { item in
                            NavigationLink(destination: TaskEditView(passedTaskItem: item)
                                .environmentObject(dateHolder)) {
                                    Text(item.name ?? "")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    AddButton().environmentObject(dateHolder)
                }
            }.navigationTitle("To Do List")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            dateHolder.saveContext(viewContext)
        }
    }
}

#Preview {
    TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
