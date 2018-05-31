//
//  TaskListPresenter.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

class TaskListPresenter {
    
    // MARK: Properties
    
    var view: TaskListViewInput!
    
    private var tableData: [TableViewModel] = []
    
    
    // MARK: - Privates
    
    private func loadTaskList() {
        appDelegate.dataManager.fetchTasks { (tasks) in
            for task in tasks {
                tableData.append(TaskCell.ViewModel(model: task))
            }
            
            self.view.reload()
        }
    }
}

extension TaskListPresenter: TaskListViewOutput {
    
    func viewDidLoad() {
        loadTaskList()
    }
}

extension TaskListPresenter: TableDataSource {
    func getViewModel(by indexPath: IndexPath) -> TableViewModel {
        return tableData[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return tableData.count
    }
}
