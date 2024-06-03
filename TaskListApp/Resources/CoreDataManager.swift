//
//  CoreDataManager.swift
//  TaskListApp
//
//  Created by abdullah on 2.06.2024.
//

import CoreData
import Foundation

class CoreDataManager{
    
    static let shared = CoreDataManager()
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    
    var contex: NSManagedObjectContext{
        persistentContainer.viewContext
    }
    
    func saveContext(){
        if contex.hasChanges{
            do {
                try contex.save()
            } catch {
                let nserror = error as NSError
                
                print("Error saving the staged changes \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    func getAll() -> [Task] {
        
        var tasks = [Task]()
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        
        fetchRequest.sortDescriptors = [sortByDueDate]
        
        do {
            
            tasks = try contex.fetch(fetchRequest)
            
            
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return tasks
    }
    
    
    func addNewTask(name: String, dueOndate: Date) {
        let task       = Task(context: contex)
        
        task.name      = name
        task.dueOn     = dueOndate
        task.id        = UUID()
        task.complated = false
        task.complatedOn = dueOndate.advanced(by: 100000)
        saveContext()
    }
    
    
    func toggleCompleted(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        
        do {
            
            if let fetchedTask = try contex.fetch(fetchRequest).first(where: { $0.id == id}){
                fetchedTask.complated = !fetchedTask.complated
                if fetchedTask.complated {
                    fetchedTask.complatedOn = Date()
                }
            }
            
            saveContext()
            
        }catch let error as NSError {
            print("Error toggleing state: \(error.userInfo), \(error.localizedDescription)")
        }
        
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        
        do {
            
            let fetchedTasks = try contex.fetch(fetchRequest)
            for task in fetchedTasks {
                contex.delete(task)
            }
            
            saveContext()
            
        }catch let error as NSError {
            print("Error delete state: \(error.userInfo), \(error.localizedDescription)")

        }
    }
    
    
}
