//
//  DefaultCategoriesConfigurator.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

class DefaultCategoriesConfigurator {
    
    static func create() -> [CategoryModel] {
        return [CategoryModel(title: "Home"),
                CategoryModel(title: "Work"),
                CategoryModel(title: "Car"),
                CategoryModel(title: "Other")]
    }
}
