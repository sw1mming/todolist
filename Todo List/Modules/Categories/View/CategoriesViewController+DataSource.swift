//
//  CategoriesViewController+DataSource.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Data Source -
//************************************************************************************

extension CategoriesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.getViewModel(by: indexPath) as! CategoryCell.ViewModel
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.className(), for: indexPath) as! CategoryCell
        cell.titleLabel.text = model.title
        return cell
    }
}


//************************************************************************************
// MARK: - Delegate -
//************************************************************************************

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let categoryViewModel = presenter.getViewModel(by: indexPath) as? CategoryCell.ViewModel else { return }
            navigationController?.pushViewController(TaskListBuilder.build(for: categoryViewModel.id,
                                                                           categoryName: categoryViewModel.title), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, nil) in
            guard let viewModel = self?.presenter.getViewModel(by: indexPath) as? CategoryCell.ViewModel else { return }
            self?.presenter.deleteCategory(id: viewModel.id)
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.move(fromIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
    }
        
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
