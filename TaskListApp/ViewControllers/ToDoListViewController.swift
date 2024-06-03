//
//  ViewController.swift
//  TaskListApp
//
//  Created by abdullah on 2.06.2024.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Task List App"
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTaskController(sender: )))
        
    }
    
    
    
    
    @objc
    func addNewTaskController(sender: UIButton){
        
        navigationController?.pushViewController(AddNewTasksViewController(), animated: true)
    }
    
    
    @objc
    func getTasks(sender: UIButton){
        let tasks = CoreDataManager.shared.getAll()
        
        for task in tasks{
            print(task.name ?? "")
        }
    }
    
    
    @objc
    func togglekComplated(sender: UIButton){
        let tasks = CoreDataManager.shared.getAll()
        
        for task in tasks {
            CoreDataManager.shared.toggleCompleted(id: task.id ?? UUID())
        }
        
        let fetchTasks = CoreDataManager.shared.getAll()
        for task in tasks {
            print(task.name ?? " ", " ", task.complated, " ", task.complatedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")
        }
    }
    
    @objc
    func deleteTask(sender: UIButton){
        let tasks = CoreDataManager.shared.getAll()
        
        for task in tasks {
            CoreDataManager.shared.delete(id: task.id ?? UUID())
        }
        
        let fetchTasks = CoreDataManager.shared.getAll()
        print(fetchTasks.count)
        for task in tasks {
            print(task.name ?? " ", " ", task.complated, " ", task.complatedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")
            
        }
    }
}

