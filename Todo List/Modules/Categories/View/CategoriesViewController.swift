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
            tableView.tableFooterView = UIView()
            tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.className())
        }
        
        setupTableView()
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = Alert(title: "Create new category",
                          textFieldPlaceholder: "Enter name (required)",
                          closure: { [weak self] text in self?.presenter.createNewCategoryWith(name: text) })
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        
        if !tableView.isEditing {
            presenter.editedDoneButtonTapped()
        }
        
        guard let items = navigationItem.rightBarButtonItems, items.count >= 2 else { return }
        let editButtonIndex = 1
        navigationItem.rightBarButtonItems?[editButtonIndex] = {
            let button = UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done : .edit,
                                         target: self,
                                         action: #selector(editButtonTapped))
            button.tintColor = .black
            return button
        }()
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
