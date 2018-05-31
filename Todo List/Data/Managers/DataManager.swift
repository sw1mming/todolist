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
}

class DataManager: DataManagerProtocol {
    
    func fetchTasks(with completion: (([TaskModel])->())) {
        fatalError("Override this method.")
    }
    
    func save(task: TaskModel, with completion: (()->())) {
        fatalError("Override this method.")
    }
}
