//
//  CreateTaskBuilder.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/31/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Create Task Builder -
//************************************************************************************

class CreateTaskBuilder {
    
    static func build(categoryId: Int) -> UIViewController {
        let view = CreateTaskViewController()
        view.presenter = CreateTaskPresenter(view: view,
                                             dataManager: appDelegate.dataManager,
                                             categoryId: categoryId)
                
        return view
    }
}
