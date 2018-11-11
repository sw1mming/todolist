//
//  TaskListRouter.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Task List Router -
//************************************************************************************

class TaskListBuilder {
    
    static func build(for categoryId: Int, categoryName: String) -> UIViewController {
        let view = TaskListViewController()
        view.presenter = TaskListPresenter(view: view, dataManager: appDelegate.dataManager, categoryId: categoryId)
        view.title = categoryName
        
        return view
    }
}
