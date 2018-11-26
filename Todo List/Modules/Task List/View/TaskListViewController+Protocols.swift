//
//  TaskListViewController+Protocols.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

// Output
protocol TaskListViewOutput: class {
    func viewDidLoad()
    func viewWillAppear()
    func deleteTaskWith(id: Int)
    func checkmarkTaskWith(_ id: Int, in categoryId: Int, isDone: Bool)
    func getCategoryId() -> Int
}

// Input
protocol TaskListViewInput: class {
    func reload()
    func show(error: String)
}
