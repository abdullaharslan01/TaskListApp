//
//  AddNewTaskViewModel.swift
//  TaskListApp
//
//  Created by abdullah on 2.06.2024.
//

import Foundation

class AddNewTaskViewModel{
    
    func addTask(name: String, dueOn: Date){
        CoreDataManager.shared.addNewTask(name: name, dueOndate: dueOn) }
    
    
    
    
}
