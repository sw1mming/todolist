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
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        presenter.viewWillAppear()
    }
    
    // MARK: - Privates
    
    private func setupDefaults() {
        func setupNavigation() {
            navigationController?.navigationBar.isTranslucent = false
            let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
            addTaskButton.tintColor = .black
            
            navigationItem.rightBarButtonItems = [addTaskButton]
        }
        
        func setupTableView() {
            tableView.tableFooterView = UIView()
            tableView.register(TaskCell.nib(), forCellReuseIdentifier: TaskCell.reuseIdentifier)
        }
        
        setupNavigation()
        setupTableView()
    }
    
    
    // MARK: - Actions
    
    @objc private func addButtonTapped() {
        present(CreateTaskBuilder.build(categoryId: presenter.getCategoryId()), animated: true, completion: nil)
    }
}


//************************************************************************************
// MARK: - View Input -
//************************************************************************************

extension TaskListViewController: TaskListViewInput {
    
    func reload() {
        tableView.reloadData()
    }
    
    func show(error: String) {
        present(Alert(title: error), animated: true, completion: nil)
    }
}
