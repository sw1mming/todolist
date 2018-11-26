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
        let viewModel = presenter.getViewModel(by: indexPath)
        
        switch viewModel {
        case is AddCategoryCell.ViewModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddCategoryCell.className(), for: indexPath) as! AddCategoryCell
            return cell.fill()
        case let model as CategoryCell.ViewModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.className(), for: indexPath) as! CategoryCell
            cell.titleLabel.text = model.title
            return cell
        default: return UITableViewCell() }
    }
}


//************************************************************************************
// MARK: - Delegate -
//************************************************************************************

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch presenter.getViewModel(by: indexPath) {
        case is AddCategoryCell.ViewModel:
            let alert = Alert(title: "Create new category",
                              textFieldPlaceholder: "Enter name (required)",
                              closure: { [weak self] text in self?.presenter.createNewCategoryWith(name: text) })
            present(alert, animated: true, completion: nil)
        case let categoryViewModel as CategoryCell.ViewModel:
            navigationController?.pushViewController(TaskListBuilder.build(for: categoryViewModel.id,
                                                                           categoryName: categoryViewModel.title), animated: true)
        default: break }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch presenter.getViewModel(by: indexPath) {
        case is AddCategoryCell.ViewModel:
            return 60
        case is CategoryCell.ViewModel:
            return CategoryCell.cellHeight
        default: return 0 }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, nil) in
            guard let viewModel = self?.presenter.getViewModel(by: indexPath) as? CategoryCell.ViewModel else { return }
            self?.presenter.deleteCategory(id: viewModel.id)
        }
        
        let move = UIContextualAction(style: .normal, title: "Move?") { [weak self] (action, view, nil) in
            self?.isEditing = !self!.isEditing
        }
        
        return UISwipeActionsConfiguration(actions: [delete, move])
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print()
    }
}
