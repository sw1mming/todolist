//
//  TaskListViewController.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Task List View -
//************************************************************************************

class TaskListViewController: UITableViewController {
    
    // MARK: Properties
    
    var presenter: (TaskListViewOutput & TableDataSource)!
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaults()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    // MARK: - Privates
    
    private func setupDefaults() {
        func setupNavigation() {
            title = "ToDo list"
            navigationController?.navigationBar.isTranslucent = false
            
            navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))]
        }
        
        func setupTableView() {
            tableView.register(TaskCell.nib(), forCellReuseIdentifier: TaskCell.reuseIdentifier)
        }
        
        setupNavigation()
        setupTableView()
    }
    
    
    // MARK: - Actions
    
    @objc private func addButtonTapped() {
        present(CreateTaskRouter.assembleModule(), animated: true, completion: nil)
    }
}


//************************************************************************************
// MARK: - View Input -
//************************************************************************************

extension TaskListViewController: TaskListViewInput {
    
    func reload() {
        tableView.reloadData()
    }
}
