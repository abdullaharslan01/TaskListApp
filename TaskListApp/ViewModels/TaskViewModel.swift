//
//  TaskViewModel.swift
//  TaskListApp
//
//  Created by abdullah on 2.06.2024.
//

import Foundation

struct TaskViewModel {
    
    private var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var id: UUID {
        task.id ?? UUID()
    }
    
    var name: String {
        task.name ?? ""
    }
    
    var dueOn: Date{
        task.dueOn ?? Date()
    }
    
    var completedOn: Date {
        task.complatedOn ?? Date()
    }
    
    var complated: Bool {
        task.complated
    }
    
}
