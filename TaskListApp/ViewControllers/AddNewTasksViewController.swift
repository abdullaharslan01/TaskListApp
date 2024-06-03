//
//  AddNewTasksViewController.swift
//  TaskListApp
//
//  Created by abdullah on 3.06.2024.
//

import UIKit

class AddNewTasksViewController: UIViewController {

    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Task Name"
        label.textColor = .label
        
        return label
    }()
    
    
    lazy var taskNameTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter task name"
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        
        return textField
        
    }()
    
    
    lazy var dueOnLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Due On"
            label.textColor = .label
            
            return label
        }()
    
    
    lazy var dueOnDatePicker: UIDatePicker = {
                let datePicker = UIDatePicker()
                datePicker.translatesAutoresizingMaskIntoConstraints = false
                
               datePicker.datePickerMode = .date
               datePicker.minimumDate    = Date()
                return datePicker
            }()
    
    
    let viewModel = AddNewTaskViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView(){
        view.backgroundColor = .systemBackground
        title = "Add New Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        [taskNameLabel,taskNameTextField,dueOnLabel,dueOnDatePicker].forEach { subViewToAdd in
            view.addSubview(subViewToAdd)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints(){
     
        NSLayoutConstraint.activate([
        
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            taskNameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            taskNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            dueOnLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant:16),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            
            dueOnDatePicker.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 16),
            dueOnDatePicker.trailingAnchor.constraint(equalTo: taskNameTextField.trailingAnchor, constant: 16)
        
        
        ])
        
        
    }
    
    
    @objc
    func saveTask(){
        guard let taskName = taskNameTextField.text , !taskName.isEmpty else {
            
            let alert = UIAlertController(title: "Error", message: "Task name can't be emty", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(alert, animated: true)
            
            return
        }
        
        viewModel.addTask(name: taskName, dueOn: dueOnDatePicker.date)
        
        navigationController?.popViewController(animated: true)
        
        
    }

    
}
