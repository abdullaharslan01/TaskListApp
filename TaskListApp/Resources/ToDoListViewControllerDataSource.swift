//
//  ToDoListViewControllerDataSource.swift
//  TaskListApp
//
//  Created by abdullah on 3.06.2024.
//

import UIKit

extension ToDoListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(by: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.reuseID, for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            
            let taskSummary = viewModel.getTasksByType()
            
            cell.configure(completed: taskSummary.complated.description, incompleted: taskSummary.incomplated.description)
            
            return cell
            
            
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseID, for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let task = viewModel.task(by: indexPath.row)
        
        cell.configure(with: task)
        
        return cell
        
    }
    
    
}
