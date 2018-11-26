//
//  CreateTaskPresenter.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/31/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation


//************************************************************************************
// MARK: - Create Task Presenter -
//************************************************************************************

class CreateTaskPresenter {
    
    weak var view: CreateTaskViewInput!
    
    var dataManager: DataManagerProtocol!
    
    var categoryId: Int!
    
    private var taskData: (title: String, description: String, identifier: String, repeats: Bool, date: Date?) = ("", "", "", false, nil)
    
    private var selectedDate: Date?
    
    init(view: CreateTaskViewInput, dataManager: DataManagerProtocol, categoryId: Int) {
        self.view = view
        self.dataManager = dataManager
        self.categoryId = categoryId
    }
    
    private var shouldShowDeleteButton: Bool {
        return taskData.identifier.isEmpty
    }
}

//************************************************************************************
// MARK: - View Output -
//************************************************************************************

extension CreateTaskPresenter: CreateTaskViewOutput {
    
    func viewDidLoad() {
        view.showDeleteNotificationButton(shouldShowDeleteButton)
    }
    
    func textDidChange(_ text: String?) {
        let isEnabled = text?.isEmpty == false
        view.enableConfirmButton(isEnabled)
        
        taskData.title = text ?? String()
    }
    
    func createButtonWasTapped() {
        let task = TaskModel()
        task.name = taskData.title
        task.notificationId = taskData.identifier
        task.date = taskData.date

        dataManager.save(task: task, for: categoryId) { [weak self] in
            self?.view.close()
        }        
    }

    func createNotificationWith(title: String?, date: Date) {
        taskData.identifier = NSUUID().uuidString
        taskData.date = date
        NotificationBuilder.buildNotificationWith(title: title ?? Strings.emptyPushTitle, date: date, identifier: taskData.identifier, repeats: taskData.repeats, completion: { [weak self] isCompleted in
            if isCompleted {
                self?.view.showDeleteNotificationButton(self!.shouldShowDeleteButton)
            }
        })
    }
    
    func deleteNotification() {
        NotificationBuilder.deleteNotificationWith(id: taskData.identifier)
        taskData.identifier = ""
        view.resetNotification()
        view.showDeleteNotificationButton(shouldShowDeleteButton)
    }
    
    func showDatePickerWasTapped() {
        taskData.title.isEmpty ? view.displayAlert(with: Strings.enterTaskName) : view.displayDatePicker()
    }
    
    func repeatSwithChanged(_ repeats: Bool) {
        taskData.repeats = repeats
    }
}
