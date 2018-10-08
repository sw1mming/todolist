//
//  CategoriesViewController.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Categories View -
//************************************************************************************

class CategoriesViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    
    
    // MARK: - Properties
    
    var presenter: (CategoriesViewOutput & TableDataSource)!
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        presenter.viewDidLoad()
    }
    
    
    // MARK: - Privates
    
    private func setupDefaults() {
        func setupTableView() {
            tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.className())
        }
        
        setupTableView()
    }
}


//************************************************************************************
// MARK: - View Input -
//************************************************************************************

extension CategoriesViewController: CategoriesViewInput {
    
    func reload() {
        tableView.reloadData()
    }
}
