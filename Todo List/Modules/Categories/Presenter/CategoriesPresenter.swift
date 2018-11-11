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
}


//************************************************************************************
// MARK: - View Output -
//************************************************************************************

extension CategoriesPresenter: CategoriesViewOutput {
    
    func viewDidLoad() {
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

            categories.isEmpty ? prepareDefaultCategories() : prepareLoadedCategories()
            tableData.append(AddCategoryCell.ViewModel())
            self?.view.reload()
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
