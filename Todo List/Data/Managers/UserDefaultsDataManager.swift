//
//  UserDefaultsDataManager.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

class UserDefaultsDataManager: DataManager {
    
    private final let TasksKey = "Tasks"
    
    override func save(task: TaskModel, with completion: (()->())) {
        loadTasksWith { (tasks) in
            var result = tasks
            
            result.append(task)
            self.save(tasks: result)
            completion()
        }
    }
    
    override func fetchTasks(with completion: (([TaskModel])->())) {
        loadTasksWith { (tasks) in
            completion(tasks)
        }
    }
    
    
    // MARK: - Privates
    
    private func loadTasksWith(completion: (([TaskModel])->())) {
        let data = UserDefaults.standard.object(forKey: TasksKey) as? NSData
        var tasksArray = [TaskModel]()
        
        if let tasks = data {
            if let currentTasksArray = NSKeyedUnarchiver.unarchiveObject(with: tasks as Data) as? [TaskModel] {
                tasksArray = currentTasksArray
            }
        }
        
        completion(tasksArray)
    }
    
    private func save(tasks: [TaskModel]) {
        let tasksData = NSKeyedArchiver.archivedData(withRootObject: tasks)
        
        UserDefaults.standard.set(tasksData, forKey: TasksKey)
        UserDefaults.standard.synchronize()
    }
}
