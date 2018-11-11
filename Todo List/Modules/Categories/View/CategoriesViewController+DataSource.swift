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
            print()
        case let categoryViewModel as CategoryCell.ViewModel:
            navigationController?.pushViewController(TaskListBuilder.build(for: categoryViewModel.id,
                                                                           categoryName: categoryViewModel.title),
                                                     animated: true)
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
}
