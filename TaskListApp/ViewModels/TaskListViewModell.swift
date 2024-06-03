//
//  TaskListViewModel.swift
//  TaskListApp
//
//  Created by abdullah on 2.06.2024.
//

import Foundation

class TaskListViewModel {
    
    var tasks = [TaskViewModel]()
        
    
    init(){
        getAll()
    }
    
    
    func getAll(){
        tasks = CoreDataManager.shared.getAll().map({ task in
            TaskViewModel.init(task: task)
        })
    }
    
    
    var numberOfTasks: Int {
            tasks.count
        }
    
    
    func numberOfRows(by section:Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return numberOfTasks
    }
    

    func getTasksByType() -> (complated:Int, incomplated: Int) {
        let completedCount  = tasks.lazy.filter ({$0.complated}).count
        let incomplatedCount = tasks.count - completedCount
        
        return (completedCount,incomplatedCount)
    }
    
    func task(by index: Int) -> TaskViewModel {
    
        return tasks[index]
        
    }
    
    
    func toggleCompleted(task: TaskViewModel) {
       
        CoreDataManager.shared.toggleCompleted(id: task.id)
       
    }
    
    
    func deleteItem(task: TaskViewModel) {
        
        CoreDataManager.shared.delete(id: task.id)
        getAll()
    }
    
    
}
