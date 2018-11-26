//
//  CategoriesPresenter.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation


//************************************************************************************
// MARK: - Presenter -
//************************************************************************************

class CategoriesPresenter {
    
    
    // MARK: - Properties
    
    var view: CategoriesViewInput!
    
    var dataManager: DataManagerProtocol!

    private var tableData: [TableViewModel] = []
    
    
    // MARK: - Life cycle
    
    init(view: CategoriesViewInput, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    
    // MARK: - Privates
    
    private func loadCategoties() {
        dataManager.fetchCategories { [weak self] categories in
            func fillTableData(with category: CategoryModel) {
                tableData.append(CategoryCell.ViewModel(category: category))
            }
            func prepareDefaultCategories() {
                DefaultCategoriesConfigurator.create().forEach({ category in
                    self?.dataManager.save(category: category, with: { _ in
                        fillTableData(with: category)
                    })
                })
            }
            func prepareLoadedCategories() {
                categories.forEach({ category in
                    fillTableData(with: category)
                })
            }
            
            tableData.append(AddCategoryCell.ViewModel())
            categories.isEmpty ? prepareDefaultCategories() : prepareLoadedCategories()
            self?.view.reload()
        }
    }
}


//************************************************************************************
// MARK: - View Output -
//************************************************************************************

extension CategoriesPresenter: CategoriesViewOutput {

    func viewDidLoad() {
        loadCategoties()
    }
    
    func createNewCategoryWith(name: String) {
        let category = CategoryModel(title: name)
        dataManager.save(category: category) { [weak self] isCompleted in
            if isCompleted {
                if let count = self?.tableData.count, count > 0 {
                    self?.tableData.insert(CategoryCell.ViewModel(category: category), at: self!.tableData.startIndex + 1)
                    self?.view.reload()
                }
            } else {
                // show error
            }
        }
    }
    
    func deleteCategory(id: Int) {
        dataManager.deleteCategoty(id: id) { [weak self] isCompleted in
            if isCompleted {
                self?.tableData.removeAll()
                self?.loadCategoties()
            } else {
                // show error
            }
        }
    }
}


//************************************************************************************
// MARK: - Table Data Source -
//************************************************************************************

extension CategoriesPresenter: TableDataSource {
    
    func getViewModel(by indexPath: IndexPath) -> TableViewModel {
        return tableData[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return tableData.count
    }
}
