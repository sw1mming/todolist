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
    
    override func deleteTask(with id: Int, with completion: (_ isCompleted: Bool)->()) {
        loadTasksWith { tasks in
            var result = tasks
            
            guard let index = result.enumerated().filter({ $0.element.id == id }).first?.offset else {
                completion(false)
                return
            }
            
            result.remove(at: index)
            self.save(tasks: result)
            completion(true)
        }
    }
    
    override func fetchTaskWith(id: Int, completion: ((TaskModel?) -> ())) {
        loadTasksWith { (tasks) in
            let task = tasks.filter({ $0.id == id }).first
            completion(task)
        }
    }
    
    override func update(task: TaskModel, with completion: ((Bool) -> ())) {
        guard let id = task.id else {
            completion(false)
            return
        }

        loadTasksWith { tasks in
            var result = tasks
            
            guard let loadedTaskEnum = result.enumerated().filter({ $0.element.id == id }).first else {
                completion(false)
                return
            }
            
            result.remove(at: loadedTaskEnum.offset)
            loadedTaskEnum.element.updateWith(task)
            result.insert(loadedTaskEnum.element, at: loadedTaskEnum.offset)
            
            self.save(tasks: result)
            completion(true)
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
