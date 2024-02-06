//
//  AddButton.swift
//  ToDoList
//
//  Created by Печик Ирина on 06.02.2024.
//

import SwiftUI

struct AddButton: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    var body: some View {
        HStack {
            NavigationLink(destination: TaskEditView(passedTaskItem: nil).environmentObject(dateHolder)) {
                Text("Add new task")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.black)
            .background(Color.yellow)
            .cornerRadius(30)
        }
    }
}

#Preview {
    AddButton()
}
