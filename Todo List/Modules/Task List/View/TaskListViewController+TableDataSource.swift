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
        cell.dateLabel.text = viewModel.dateString
        cell.indicatorImageView.image = UIImage(named: viewModel.isDone ? "ic_checkmark" : "ic_close")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let viewModel = self.presenter.getViewModel(by: indexPath) as? TaskCell.ViewModel else { return nil }
        
        let action = UIContextualAction(style: .normal, title: viewModel.isDone ? "Un Done" : "Done") { [weak self] (action, view, nil) in
            guard let id = viewModel.id else { return }
            
            self?.presenter.checkmarkTaskWith(id, in: self!.presenter.getCategoryId(), isDone: !viewModel.isDone)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, nil) in
            guard let viewModel = self?.presenter.getViewModel(by: indexPath) as? TaskCell.ViewModel,
                  let id = viewModel.id else { return }
            self?.presenter.deleteTaskWith(id: id)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
