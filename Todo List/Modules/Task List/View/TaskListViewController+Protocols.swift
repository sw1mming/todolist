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
}

// Input
protocol TaskListViewInput: class {
    func reload()
}
