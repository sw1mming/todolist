//
//  CategoriesBuilder.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

class CategoriesBuilder {
    
    static func build() -> UIViewController {
        let navigation = UIStoryboard(name: CategoriesViewController.className(), bundle: nil).instantiateInitialViewController() as! UINavigationController
        let view = navigation.viewControllers.first as! CategoriesViewController

        view.presenter = CategoriesPresenter(view: view, dataManager: appDelegate.dataManager)
        
        return navigation
    }
}
