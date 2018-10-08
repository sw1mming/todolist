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
        let category = presenter.getViewModel(by: indexPath) as! CategoryCell.ViewModel
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.className(), for: indexPath) as! CategoryCell
        cell.titleLabel.text = category.title
        
        return cell
    }
}


//************************************************************************************
// MARK: - Delegate -
//************************************************************************************

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryCell.cellHeight
    }
}
