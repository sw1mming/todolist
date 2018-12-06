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
    
    private var movedCategories = (isChanged: false, array: [CategoryModel]())
    
    
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
                movedCategories.array = categories
                categories.forEach({ category in
                    fillTableData(with: category)
                })
            }
            
            categories.isEmpty ? prepareDefaultCategories() : prepareLoadedCategories()
            self?.view.reload()
        }
    }
}


//************************************************************************************
// MARK: - View Output -
//************************************************************************************

extension CategoriesPresenter: CategoriesViewOutput {

    func viewDidLoad() { loadCategoties() }
    
    func createNewCategoryWith(name: String) {
        let category = CategoryModel(title: name)
        dataManager.save(category: category) { [weak self] isCompleted in
            if isCompleted {
                if let count = self?.tableData.count, count > 0 {
                    self?.tableData.insert(CategoryCell.ViewModel(category: category), at: self!.tableData.startIndex)
                    self?.movedCategories.array.insert(category, at: self!.tableData.startIndex)
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
    
    func move(fromIndexPath: IndexPath, toIndexPath: IndexPath) {
        movedCategories.isChanged = true
        let category = movedCategories.array[fromIndexPath.row];     let viewModel = tableData[fromIndexPath.row]
        movedCategories.array.remove(at: fromIndexPath.row);         tableData.remove(at: fromIndexPath.row)
        movedCategories.array.insert(category, at: toIndexPath.row); tableData.insert(viewModel, at: toIndexPath.row)
    }
    
    func editedDoneButtonTapped() {
        guard movedCategories.isChanged else { return }
        movedCategories.isChanged = false
        dataManager.save(categories: movedCategories.array)
    }
}


//************************************************************************************
// MARK: - Table Data Source -
//************************************************************************************

extension CategoriesPresenter: TableDataSource {
    
    func getViewModel(by indexPath: IndexPath) -> TableViewModel {
        return tableData[indexPath.row]
    }
    
    func numberOfRows() -> Int { return tableData.count }
}
