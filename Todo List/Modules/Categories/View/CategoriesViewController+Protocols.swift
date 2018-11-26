//
//  CategoriesViewController+Protocols.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

// Output
protocol CategoriesViewOutput {
    func viewDidLoad()
    func createNewCategoryWith(name: String)
    func deleteCategory(id: Int)
}

// Input
protocol CategoriesViewInput {
    func reload()
}
