//
//  ToDoTableViewCell.swift
//  TaskListApp
//
//  Created by abdullah on 3.06.2024.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    
    static let reuseID = "ToDoTableViewCell"

    lazy var taskNameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
        return v
    }()
    
    
    lazy var dueOrComplatedLabel: UILabel = {
            let v = UILabel()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.font = UIFont.systemFont(ofSize: 14)
            return v
        }()
    
    lazy var completedLabel: UILabel = {
                let v = UILabel()
                v.translatesAutoresizingMaskIntoConstraints = false
                v.font = UIFont.systemFont(ofSize: 14)
                return v
            }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    func setupView(){
        selectionStyle = .none
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(dueOrComplatedLabel)
        contentView.addSubview(completedLabel)
    
        setupConstaints()
    }
    
    func setupConstaints(){
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        
            dueOrComplatedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            dueOrComplatedLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor),
            dueOrComplatedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            
            completedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            completedLabel.trailingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor),
            completedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            contentView.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: taskNameLabel.bottomAnchor, multiplier: 8)
        
        ])
    }
    
    func configure(with task: TaskViewModel) {
        let attributedString = NSMutableAttributedString(string: task.name)
        
        if task.complated {
            attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
            
            taskNameLabel.font = UIFont.italicSystemFont(ofSize: 16)
        } else {
            taskNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        
        taskNameLabel.attributedText = attributedString
        
        dueOrComplatedLabel.text = task.complated ? "Complated on \(task.completedOn.formatted(date: .abbreviated, time: .omitted))" : "Due on: \(task.dueOn.formatted(date: .abbreviated, time: .omitted))"
        
        completedLabel.text = task.complated ? "Completed": "Not Completed"
        
        completedLabel.textColor = task.complated ? .green : .red
        
    }
   

}
