//
//  UserDefaultsDataManager.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

class UserDefaultsDataManager: DataManagerProtocol {
    
    enum Key {
        static let tasks = "tasks"
        static let categories = "categories"
    }
    
    var currentCategoryId: Int = 0
    
    func save(category: CategoryModel, with completion: (() -> ())) {
        loadCategoriesWith { [weak self] categories in
            var result = categories
            
            result.append(category)
            self?.save(categories: result)
            completion()
        }
    }
    
    func fetchCategories(with completion: (([CategoryModel]) -> ())) {
        loadCategoriesWith { categories in
            completion(categories)
        }
    }
    
    func save(task: TaskModel, with completion: (()->())) {
        loadTasksWith { [weak self] tasks in
            var result = tasks
            
            result.append(task)
            self?.save(tasks: result)
            completion()
        }
    }
    
    func fetchTasks(of categoryId: Int, completion: (([TaskModel]) -> ())) {
        loadCategoriesWith { categories in
            guard let tasks = categories.filter({ $0.id == categoryId }).first?.tasks else { completion([]); return }
            completion(tasks)
        }
    }
    
    func fetchTasks(with completion: (([TaskModel])->())) {
        loadTasksWith { (tasks) in
            completion(tasks)
        }
    }
    
    func deleteTask(with id: Int, with completion: (_ isCompleted: Bool)->()) {
        loadTasksWith { [weak self] tasks in
            var result = tasks
            
            guard let index = result.enumerated().filter({ $0.element.id == id }).first?.offset else {
                completion(false)
                return
            }
            
            result.remove(at: index)
            self?.save(tasks: result)
            completion(true)
        }
    }
    
    func fetchTaskWith(id: Int, completion: ((TaskModel?) -> ())) {
        loadTasksWith { (tasks) in
            let task = tasks.filter({ $0.id == id }).first
            completion(task)
        }
    }
    
    func update(task: TaskModel, with completion: ((Bool) -> ())) {
        guard let id = task.id else {
            completion(false)
            return
        }

        loadTasksWith { [weak self] tasks in
            var result = tasks
            
            guard let loadedTaskEnum = result.enumerated().filter({ $0.element.id == id }).first else {
                completion(false)
                return
            }
            
            result.remove(at: loadedTaskEnum.offset)
            loadedTaskEnum.element.updateWith(task)
            result.insert(loadedTaskEnum.element, at: loadedTaskEnum.offset)
            
            self?.save(tasks: result)
            completion(true)
        }

    }
    
    // MARK: - Privates
    
    // MARK: Tasks
    
    private func loadTasksWith(completion: (([TaskModel])->())) {
        let data = UserDefaults.standard.object(forKey: Key.tasks) as? NSData
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
        
        UserDefaults.standard.set(tasksData, forKey: Key.tasks)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: Categories
    
    private func loadCategoriesWith(completion: (([CategoryModel])->())) {
        let data = UserDefaults.standard.object(forKey: Key.categories) as? NSData
        var categoriesArray = [CategoryModel]()
        
        if let tasks = data {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: tasks as Data) as? [CategoryModel] {
                categoriesArray = array
            }
        }
        
        completion(categoriesArray)
    }
    
    private func save(categories: [CategoryModel]) {
        let tasksData = NSKeyedArchiver.archivedData(withRootObject: categories)
        
        UserDefaults.standard.set(tasksData, forKey: Key.categories)
        UserDefaults.standard.synchronize()
    }
}
