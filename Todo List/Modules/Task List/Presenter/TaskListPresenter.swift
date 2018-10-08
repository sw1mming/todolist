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
    
    private weak var view: TaskListViewInput!
    
    private let dataManager: DataManagerProtocol
    
    private let categoryId: Int
    
    private var tableData: [TableViewModel] = []
    
    
    // MARK: - Life cycle
    
    init(view: TaskListViewInput, dataManager: DataManagerProtocol, categoryId: Int) {
        self.view = view
        self.dataManager = dataManager
        self.categoryId = categoryId
    }
    
    
    // MARK: - Privates
    
    private func loadTaskList() {
        tableData.removeAll()
        
        dataManager.fetchTasks { [weak self] tasks in
            for task in tasks {
                self?.tableData.append(TaskCell.ViewModel(model: task))
            }
            
            self?.view.reload()
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
        dataManager.fetchTaskWith(id: id) { task in
            guard let id = task?.notificationId else { return }
            NotificationBuilder.deleteNotificationWith(id: id)
        }
        
        dataManager.deleteTask(with: id) { [weak self] isCompleted in
            guard isCompleted else {
                // ToDo: Display Error.
                return
            }
            
            self?.loadTaskList()
        }
    }
    
    func checkmarkTaskWith(_ id: Int, isDone: Bool) {
        dataManager.fetchTaskWith(id: id) { [weak self] task in
            guard let task = task else { return }
            task.isDone = isDone
            dataManager.update(task: task, with: { isCompleted in
                isCompleted
                    ? self?.loadTaskList()
                    : self?.view.show(error: "Can't update your task.")
            })
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
