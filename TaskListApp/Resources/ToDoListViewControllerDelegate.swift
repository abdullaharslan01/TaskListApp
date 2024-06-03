//
//  ToDoListViewControllerDelegate.swift
//  TaskListApp
//
//  Created by abdullah on 3.06.2024.
//

import UIKit

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = viewModel.task(by: indexPath.row)
        
        let complateAction = UIContextualAction(style: .normal, title: task.complated ? "Not completed" : "Complete") { [weak self] action, view, completion in
            self?.complateTask(at: indexPath)
            completion(true)
        }
        
        complateAction.backgroundColor = task.complated ? .systemRed : .systemGreen
        
        let configuration = UISwipeActionsConfiguration(actions: [complateAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
    
    func complateTask(at indexPath: IndexPath) {
        let task = viewModel.task(by: indexPath.row)
        viewModel.toggleCompleted(task: task)
        
        if task.complated {
            celebrateAnimationView.isHidden = false
            celebrateAnimationView.play { [weak self] finished in
                self?.celebrateAnimationView.isHidden = finished
            }
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        let task = viewModel.task(by: indexPath.row)
        
        viewModel.deleteItem(task: task)
        
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }
}
