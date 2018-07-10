//
//  TaskListViewController+TableDataSource.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - TableView Data Source & Delegate -
//************************************************************************************

extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = presenter.getViewModel(by: indexPath) as! TaskCell.ViewModel
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
        cell.nameLabel.text = viewModel.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let viewModel = self.presenter.getViewModel(by: indexPath) as! TaskCell.ViewModel
        
        let action = UIContextualAction(style: .normal, title: viewModel.isDone ? "Done" : "Un Done") { [weak self] (action, view, nil) in
            guard let id = viewModel.id else { return }
            self?.presenter.checkmarkTaskWith(id, isDone: !viewModel.isDone)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            let viewModel = self.presenter.getViewModel(by: indexPath) as! TaskCell.ViewModel
            self.presenter.deleteTaskWith(id: viewModel.id!)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
