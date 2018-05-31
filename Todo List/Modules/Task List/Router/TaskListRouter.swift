//
//  TaskListRouter.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

class TaskListRouter {
    
    static func assembleModule() -> UIViewController {
        let view = TaskListViewController()
        let presenter = TaskListPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        
        return UINavigationController(rootViewController: view)
    }
}
