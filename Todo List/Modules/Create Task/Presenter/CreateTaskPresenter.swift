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
    
    private var taskData = (title: "", description: "")    
}

//************************************************************************************
// MARK: - View Output -
//************************************************************************************

extension CreateTaskPresenter: CreateTaskViewOutput {
    
    func viewDidLoad() {}
    
    func textDidChange(_ text: String?) {
        let isEnabled = text?.isEmpty == false
        view.enableConfirmButton(isEnabled)
        taskData = isEnabled ? (text!, "") : ("", "")
    }
    
    func createButtonWasTapped() {
        let task = TaskModel()
        task.name = taskData.title
        appDelegate.dataManager.save(task: task) {
            view.close()
        }
    }
}
