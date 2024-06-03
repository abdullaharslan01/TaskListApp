//
//  ViewController.swift
//  TaskListApp
//
//  Created by abdullah on 2.06.2024.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    var viewModel = TaskListViewModel()
    
    lazy var tableView: UITableView = {
       
        
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate   = self
        v.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseID)
        v.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.reuseID)
        v.estimatedRowHeight = 200
        v.rowHeight = UITableView.automaticDimension
        
        return v
        
    }()
    
    lazy var celebrateAnimationView: CelebrationAnimationView = {
        let v = CelebrationAnimationView(fileName: "celeprationAnimation")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        
        return v
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Task List App"
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTaskController(sender: )))
        view.addSubview(tableView)
        view.addSubview(celebrateAnimationView)
        NSLayoutConstraint.activate([
            celebrateAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            celebrateAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            celebrateAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
            celebrateAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            
            
        ])
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAll()
        tableView.reloadData()
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

