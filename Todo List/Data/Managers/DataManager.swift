//
//  DataManager.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    
    func fetchTasks(with completion: (([TaskModel])->()))
    
    func save(task: TaskModel, with completion: (()->()))
    
    func deleteTask(with id: Int, with completion: (_ isCompleted: Bool)->())
}

class DataManager: DataManagerProtocol {
    
    func fetchTasks(with completion: (([TaskModel])->())) {
        fatalError("Override this method.")
    }
    
    func save(task: TaskModel, with completion: (()->())) {
        fatalError("Override this method.")
    }
    
    func deleteTask(with id: Int, with completion: (_ isCompleted: Bool)->()) {
        fatalError("Override this method.")
    }
}
