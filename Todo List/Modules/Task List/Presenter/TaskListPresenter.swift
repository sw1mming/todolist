//
//  TaskListPresenter.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation


//************************************************************************************
// MARK: - Task List Presenter -
//************************************************************************************

class TaskListPresenter {
    
    // MARK: Properties
    
    var view: TaskListViewInput!
    
    var dataManager: DataManagerProtocol!
    
    private var tableData: [TableViewModel] = []
    
    
    // MARK: - Privates
    
    private func loadTaskList() {
        tableData.removeAll()
        
        dataManager.fetchTasks { (tasks) in
            for task in tasks {
                self.tableData.append(TaskCell.ViewModel(model: task))
            }
            
            self.view.reload()
        }
    }
}

//************************************************************************************
// MARK: - View Output -
//************************************************************************************

extension TaskListPresenter: TaskListViewOutput {
    
    func viewDidLoad() {
        loadTaskList()
    }
    
    func viewWillAppear() {
        loadTaskList()
    }
    
    func deleteTaskWith(id: Int) {
        dataManager.deleteTask(with: id) { (isCompleted) in
            guard isCompleted else {
                // ToDo: Display Error.
                return
            }
            
            self.loadTaskList()
        }
    }
}

//************************************************************************************
// MARK: - Table Data Source -
//************************************************************************************

extension TaskListPresenter: TableDataSource {
    
    func getViewModel(by indexPath: IndexPath) -> TableViewModel {
        return tableData[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return tableData.count
    }
}
