//
//  CreateTaskRouter.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/31/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Create Task Router -
//************************************************************************************

class CreateTaskRouter {
    
    static func assembleModule() -> UIViewController {
        let view = CreateTaskViewController()
        let presenter = CreateTaskPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
