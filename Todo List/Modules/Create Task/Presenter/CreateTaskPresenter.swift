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
    
    private var taskData = (title: "", description: "", identifier: "")
    
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
        
        dataManager.save(task: task) {
            view.close()
        }
    }

    func createNotificationWith(title: String?, date: Date) {
        taskData.identifier = NSUUID().uuidString
        
        NotificationBuilder.buildNotificationWith(title: title ?? Strings.emptyPushTitle, date: date, identifier: taskData.identifier, completion: { [weak self] isCompleted in
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
}
