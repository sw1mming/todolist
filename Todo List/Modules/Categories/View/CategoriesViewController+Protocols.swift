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
}

// Input
protocol CategoriesViewInput {
    func reload()
}
