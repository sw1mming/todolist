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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, indexPath in
            let viewModel = self.presenter.getViewModel(by: indexPath) as! TaskCell.ViewModel
            self.presenter.deleteTaskWith(id: viewModel.id!)
        }
        delete.backgroundColor = .lightGray
        
        return [delete]
    }
}
